OME-TIFF specification
======================

Overview
--------

An OME-TIFF dataset consists of:

- Image planes stored in one or more standard multi-page `TIFF
  <https://en.wikipedia.org/wiki/TIFF>`_ files, with the file
  extension ``.ome.tif`` or ``.ome.tiff`` or `BigTIFF format
  <http://www.awaresystems.be/imaging/tiff/bigtiff.html/>`_ with one
  of these same file extensions or a BigTIFF-specific extension
  ``.ome.tf2``, ``.ome.tf8`` or ``.ome.btf``.  The organisation of
  planes is flexible; any possible order and distribution between
  files is permitted.
- OME-XML metadata embedded in the ImageDescription tag of the first
  IFD (Image File Directory) of each file. This XML string must be
  UTF-8 encoded.  Alternatively, the OME-XML metadata may be placed in
  a companion XML file, with the TIFF images containing a minimal
  amount of metadata referencing the companion file.  Each file has a
  unique identifier (UUID).
- The OME-XML metadata may contain elements and attributes allowed in
  a standard OME-XML file, with the exception of ``BinData`` elements,
  which are replaced with ``TiffData`` elements.  This replaces
  Base64-encoded image data with references to the TIFF file and IFD
  for each plane.  OME-TIFF readers and writers are not required to
  be able to handle ``BinData`` elements where ``TiffData`` may be
  used instead.

.. warning:: I combined two duplicate sections to create the above
    three points.  Should be functionally the same, but needs
    double-checking.
  
TIFF
----

.. warning:: I removed a TIFF diagram here since it's redundant (it's
             all in the official spec), and it included OME-XML 2003!

The `TIFF specification
<http://partners.adobe.com/public/developer/en/tiff/TIFF6.pdf>`__
defines the TIFF file format.  An overview of the basic data
structures exists in the `TIFF FAQ
<http://www.awaresystems.be/imaging/tiff/faq.html>`__.  Note that the
file structures vary slightly between TIFF and BigTIFF.  TIFF files
may be read and written using the specification alone, but it is more
common to use a TIFF library such as the `libtiff
<http://www.simplesystems.org/libtiff/>`__ C library, or Java ImageIO,
or the Bio-Formats TIFF parser and saver classes.  Other languages may
provide their own TIFF libraries.

A TIFF file can contain any number of IFDs, with each one specifying
an image plane along with certain accompanying metadata such as pixel
dimensions, physical dimensions, bit depth, color lookup table,
etc. One of the fields an IFD can contain is ``ImageDescription``,
which provides a place to write a comment describing the metadata for
this and all the other planes within the dataset.

The minimum requirement for any TIFF reader and writer is that they
must be able to read and write the pixel data as separate IFDs, and
they must be able to save and edit the ``ImageDescription`` field to
add the required OME XML metadata.  This is the case for all of the
common TIFF libraries.

OME-XML metadata
----------------

A UTF-8 string containing valid OME XML text.  While the OME-XML file
format stores pixel data within ``BinData`` elements using Base64
encoding, OME-TIFF references pixel data using ``TiffData`` elements
to specify which TIFF file and IFD corresponds to each image plane.
The OME-XML string can be considered to contain only metadata, a
"metadata block", because all pixel data is stored within the TIFF
directory structure, not within the XML.

A TIFF file contains one IFD per image plane.  The OME XML metadata
block is stored only in the *first* IFD.  For a dataset distributed
between multiple OME-TIFF files, the OME XML metadata block is stored
in the *first IFD of each file*. (see :ref:`binary_only`, below, for
exceptions to this rule). This metadata duplication is to ensure that
the metadata will be completely preserved if any files in the dataset
are lost. The duplicated OME XML metadata blocks are nearly identical,
the difference being the file UUIDs differ between files.

When embedding the OME-XML string as a TIFF comment, it is best
practice to preface it with the following informative comment::

    <!-- Warning: this comment is an OME-XML metadata block, which contains
    crucial dimensional parameters and other important metadata. Please edit
    cautiously (if at all), and back up the original data before doing so.
    For more information, see the OME-TIFF web site:
    http://www.openmicroscopy.org/site/support/ome-model/ome-tiff/ -->

.. _tiffdata:

The TiffData element
--------------------

The :schema_doc:`TiffData <ome_xsd.html#TiffData>` element is used to
specify where to locate an image plane (the file and IFD).  By
default, the first IFD corresponds to the first image plane
(*Z0-T0-C0*), and the order of subsequent IFDs is described by the
``DimensionOrder`` attribute of the ``Pixels`` element.

Several attributes provide greater control over the dimensional
position of each IFD.  Using these is recommended to avoid any
ambiguity, particularly when using data sets with multiple ``Image``
elements or which are split over multiple files.

:schema_doc:`IFD <ome_xsd.html#TiffData_IFD>`
  specifies the IFD(s) for which this element is applicable.  Indexed
  from 0. Default is 0 (the first IFD).
:schema_doc:`FirstZ <ome_xsd.html#TiffData_FirstZ>`
  specifies the *Z* position of the image plane at the specified
  IFD. Indexed from 0. Default is 0 (the first *Z* position).
:schema_doc:`FirstT <ome_xsd.html#TiffData_FirstT>`
  specifies the *T* position of the image plane at the specified
  IFD. Indexed from 0. Default is 0 (the first *T* position).
:schema_doc:`FirstC <ome_xsd.html#TiffData_FirstC>`
  specifies the *C* position of the image plane at the specified
  IFD. Indexed from 0. Default is 0 (the first *C* position).
:schema_doc:`PlaneCount <ome_xsd.html#TiffData_PlaneCount>`
  specifies the number of IFDs to be included after the starting
  IFD. Dimension order of IFDs is given by the ``DimensionOrder``
  attribute of the enclosing ``Pixels`` element.  The Default is the
  number of IFDs in the TIFF file, unless an IFD is specified, in
  which case the default is 1.

Here are some example XML fragments:

Fragment 1
^^^^^^^^^^

::

    <Pixels ID="urn:lsid:loci.wisc.edu:Pixels:ows325"
            Type="uint8" DimensionOrder="XYZTC"
            SizeX="512" SizeY="512" SizeZ="3" SizeT="2" SizeC="2">
        <TiffData/>
    </Pixels>

+-------+-----------------+
| IFD   | Position        |
+=======+=================+
| 0     | Z0-T0-C0        |
+-------+-----------------+
| 1     | Z1-T0-C0        |
+-------+-----------------+
| 2     | Z2-T0-C0        |
+-------+-----------------+
| 3     | Z0-T1-C0        |
+-------+-----------------+
| 4     | Z1-T1-C0        |
+-------+-----------------+
| 5     | Z2-T1-C0        |
+-------+-----------------+
| 6     | Z0-T0-C1        |
+-------+-----------------+
| 7     | Z1-T0-C1        |
+-------+-----------------+
| 8     | Z2-T0-C1        |
+-------+-----------------+
| 9     | Z0-T1-C1        |
+-------+-----------------+
| 10    | Z1-T1-C1        |
+-------+-----------------+
| 11    | Z2-T1-C1        |
+-------+-----------------+

The default TiffData tag simply assigns every IFD to a position
according to the given DimensionOrder rasterization. If the TIFF file
has more than SizeZ\*SizeT\*SizeC (3\*2\*2=12 in this case) IFDs, the
remaining IFDs are extraneous and should be ignored by OME-TIFF readers.

Fragment 2
^^^^^^^^^^

::

    <Pixels ID="urn:lsid:loci.wisc.edu:Pixels:ows462"
            Type="uint8" DimensionOrder="XYCTZ"
            SizeX="512" SizeY="512" SizeZ="4" SizeT="3" SizeC="2">
        <TiffData PlaneCount="10"/>
    </Pixels>

+-------+-----------------+
| IFD   | Position        |
+=======+=================+
| 0     | Z0-T0-C0        |
+-------+-----------------+
| 1     | Z0-T0-C1        |
+-------+-----------------+
| 2     | Z0-T1-C0        |
+-------+-----------------+
| 3     | Z0-T1-C1        |
+-------+-----------------+
| 4     | Z0-T2-C0        |
+-------+-----------------+
| 5     | Z0-T2-C1        |
+-------+-----------------+
| 6     | Z1-T0-C0        |
+-------+-----------------+
| 7     | Z1-T0-C1        |
+-------+-----------------+
| 8     | Z1-T1-C0        |
+-------+-----------------+
| 9     | Z1-T1-C1        |
+-------+-----------------+

When specified, the PlaneCount attribute gives the number of IFDs
affected by the TiffData element. In this case, even though the Pixels
element defines 4\*3\*2=24 image planes total, the TiffData element
assigns only 10 planes. The remaining 14 planes are unspecified and
hence lost.

Fragment 3
^^^^^^^^^^

::

    <Pixels ID="urn:lsid:loci.wisc.edu:Pixels:ows197"
            Type="uint8" DimensionOrder="XYZTC"
            SizeX="512" SizeY="512" SizeZ="4" SizeC="3" SizeT="2">
        <TiffData IFD="3" PlaneCount="5"/>
    </Pixels>

+-------+-----------------+
| IFD   | Position        |
+=======+=================+
| 3     | Z0-T0-C0        |
+-------+-----------------+
| 4     | Z1-T0-C0        |
+-------+-----------------+
| 5     | Z2-T0-C0        |
+-------+-----------------+
| 6     | Z3-T0-C0        |
+-------+-----------------+
| 7     | Z0-T1-C0        |
+-------+-----------------+

States that the rasterization begins at the fourth IFD (IFD #3), and
continues for five planes total. IFDs #0, #1 and #2 are not used, and
should be ignored by OME-TIFF readers.

Fragment 4
^^^^^^^^^^

::

    <Pixels ID="urn:lsid:loci.wisc.edu:Pixels:ows789"
            Type="uint8" DimensionOrder="XYZTC"
            SizeX="512" SizeY="512" SizeZ="1" SizeC="1" SizeT="6">
        <TiffData IFD="0" FirstT="5"/>
        <TiffData IFD="1" FirstT="4"/>
        <TiffData IFD="2" FirstT="3"/>
        <TiffData IFD="3" FirstT="2"/>
        <TiffData IFD="4" FirstT="1"/>
        <TiffData IFD="5" FirstT="0"/>
   </Pixels>

+-------+-----------------+
| IFD   | Position        |
+=======+=================+
| 0     | Z0-T5-C0        |
+-------+-----------------+
| 1     | Z0-T4-C0        |
+-------+-----------------+
| 2     | Z0-T3-C0        |
+-------+-----------------+
| 3     | Z0-T2-C0        |
+-------+-----------------+
| 4     | Z0-T1-C0        |
+-------+-----------------+
| 5     | Z0-T0-C0        |
+-------+-----------------+

Any number of TiffData elements may be provided. In this case, the dimensional 
positions of each of the first six IFDs are explicitly defined, effectively 
overriding the rasterization given by DimensionOrder, storing the planes in 
reverse temporal order.


For details on validating your OME-XML metadata block, see the
validating OME-XML section on the :doc:`tools` page.

.. _multifile-ometiff:

Multi-file OME-TIFF
-------------------

As demonstrated above, the OME-TIFF format is capable of storing the
entire multidimensional image series in one master OME-TIFF file.

Alternatively, a collection of multiple OME-TIFF files may be used. Using
the TiffData attributes outlined above together with
`UUID <https://en.wikipedia.org/wiki/Universally_Unique_Identifier>`_
elements and attributes, the OME-XML metadata block can unambiguously
define which dimensional positions correspond to which IFDs from which
files. Each OME-TIFF need not contain the same number of images.

The only difference between the OME-XML metadata block per TIFF file is the
:schema_doc:`UUID <ome_xsd.html#OME_UUID>`
attribute of the root OME element. This value should be a distinct
UUID value for each file, so that each TiffData element can
unambiguously reference its relevant file using a UUID child element.

.. note::
    The :schema_doc:`FileName <ome_xsd.html#TiffData_TiffData_UUID_FileName>`
    attribute of the UUID is optional, but strongly recommended—otherwise,
    the OME-TIFF reader must scan OME-TIFF files in the working directory
    looking for matching UUID signatures.

When splitting an OME-TIFF across multiple files, the OME-XML metadata must
either be embedded into each TIFF file or use partial metadata blocks.

Embedded OME-XML metadata
^^^^^^^^^^^^^^^^^^^^^^^^^

In the first case, a nearly identical OME-XML metadata block must be inserted
into the first IFD of each constituent OME-TIFF file.

The only difference between the OME-XML metadata block per TIFF file is the
:schema_doc:`UUID <ome_xsd.html#OME_UUID>`
attribute of the root OME element. This value should be a distinct
UUID value for each file, so that each TiffData element can
unambiguously reference its relevant file using a UUID child element.

The :ref:`tubhiswt_samples` demonstrate how OME-TIFF datasets can be
distributed across multiple files. Each of the files in the set has identical
metadata apart from the `UUID`, the unique identifier in each file. For
example the identifiers could be distributed as follows:

**tubhiswt_C0_TP0.ome.tif** with ID 45c8bf18-6aa2-478c-9080-e0b0d3eb1f70

::

    <OME xmlns="http://www.openmicroscopy.org/Schemas/OME/2016-06"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         Creator="OME Bio-Formats 5.2.0-m4"
         UUID="urn:uuid:45c8bf18-6aa2-478c-9080-e0b0d3eb1f70"
         xsi:schemaLocation="http://www.openmicroscopy.org/Schemas/OME/2016-06
         http://www.openmicroscopy.org/Schemas/OME/2016-06/ome.xsd">
    ...
        <Pixels BigEndian="false" DimensionOrder="XYZTC" ID="Pixels:0"
                Interleaved="false" SignificantBits="8" SizeC="2" SizeT="43"
                SizeX="512" SizeY="512" SizeZ="10" Type="uint8">
    ...
          <TiffData FirstC="0" FirstT="0" FirstZ="0" IFD="0" PlaneCount="1">
            <UUID FileName="tubhiswt_C0_TP0.ome.tif">
              urn:uuid:45c8bf18-6aa2-478c-9080-e0b0d3eb1f70
            </UUID>
          </TiffData>
    ...
          <TiffData FirstC="0" FirstT="1" FirstZ="1" IFD="1" PlaneCount="1">
            <UUID FileName="tubhiswt_C0_TP1.ome.tif">
              urn:uuid:743275b7-6726-46bd-b7bb-aca3085f429a
            </UUID>
          </TiffData>
    ...

**tubhiswt_C0_TP1.ome.tif** with ID 743275b7-6726-46bd-b7bb-aca3085f429a

::

    <OME xmlns="http://www.openmicroscopy.org/Schemas/OME/2016-06"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         Creator="OME Bio-Formats 5.2.0-m4" 
         UUID="urn:uuid:743275b7-6726-46bd-b7bb-aca3085f429a"
         xsi:schemaLocation="http://www.openmicroscopy.org/Schemas/OME/2016-06
         http://www.openmicroscopy.org/Schemas/OME/2016-06/ome.xsd"
    ...
        <Pixels BigEndian="false" DimensionOrder="XYZTC" ID="Pixels:0"
                Interleaved="false" SignificantBits="8" SizeC="2" SizeT="43"
                SizeX="512" SizeY="512" SizeZ="10" Type="uint8">
    ...
          <TiffData FirstC="0" FirstT="0" FirstZ="0" IFD="0" PlaneCount="1">
            <UUID FileName="tubhiswt_C0_TP0.ome.tif">
              urn:uuid:45c8bf18-6aa2-478c-9080-e0b0d3eb1f70
            </UUID>
          </TiffData>
    ...
          <TiffData FirstC="0" FirstT="1" FirstZ="0" IFD="0" PlaneCount="1">
            <UUID FileName="tubhiswt_C0_TP1.ome.tif">
              urn:uuid:743275b7-6726-46bd-b7bb-aca3085f429a
            </UUID>
          </TiffData>
    ...

And so on for files:

- **tubhiswt_C0_TP2.ome.tif** with ID 1f462b60-b508-446e-b42a-c4e6fa2a44e8
- **tubhiswt_C0_TP3.ome.tif** with ID a023901d-43fd-44f2-b4be-159afa1e985c
- ...

.. _binary_only:

Partial OME-XML metadata
^^^^^^^^^^^^^^^^^^^^^^^^

Instead of embedding the full OME-XML metadata into the header of each
OME-TIFF, partial OME-XML metadata blocks can be stored in some or all of the
OME-TIFF files using the
:schema_doc:`Binary-Only <ome_xsd.html#OME_BinaryOnly>`
element as illustrated below::

    <?xml version="1.0" encoding="UTF-8"?>
    <OME UUID="urn:uuid:4978087c-a670-4b12-af53-256c62d8d101"
         xmlns="http://www.openmicroscopy.org/Schemas/OME/2016-06"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://www.openmicroscopy.org/Schemas/OME/2016-06
         http://www.openmicroscopy.org/Schemas/OME/2016-06/ome.xsd">
       <BinaryOnly MetadataFile="multifile.companion.ome"
                   UUID="urn:uuid:07504f88-7bc3-11e0-b937-2faf67bc00b3"/>
    </OME>

The :schema_doc:`MetadataFile <ome_xsd.html#OME_OME_BinaryOnly_MetadataFile>`
element should contain the name of the master file containing the full
OME-XML metadata  block and
:schema_doc:`UUID <ome_xsd.html#OME_OME_BinaryOnly_UUID>`
should contain the UUID of this master file.

The master file containing the full OME-XML metadata should be either an
OME-XML companion file with the extension :file:`.companion.ome` or a master
OME-TIFF file containing the full metadata (see :ref:`multifile_samples` for
representative samples).

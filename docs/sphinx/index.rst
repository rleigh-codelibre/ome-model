###################################
OME Metadata Model and File Formats
###################################

This documentation covers the OME Metadata Model, and the OME-TIFF and
OME-XML file formats using the metadata model.

The OME Metadata Model is a formal specification for metadata relating
to biological imaging.  The model includes image parameters, such as
the XYZ dimensions and pixel type and size, and also includes
instrument setup and image acquisition parameters, regions of interest
(ROIs) and custom annotations to permit user extension of the stored
metadata. This specification allows the exchange of image data and
metadata between different software packages, from acquisition to
analysis, visualisation, publication and archival.

OME-TIFF is an image file format consisting of one or more multi-plane
TIFF files which contain OME XML metadata in the header, or in an
associated companion XML file. The pixel data may be read with any
program supporting TIFF, and the OME XML metadata may be extracted
with any OME-aware application.

OME-XML is a file format used to store data using to the OME Metadata
Model, serving as a convenient file format for data migration from one
site or user to another.


**************
Metadata model
**************

.. toctree::
    :maxdepth: 1
    :titlesonly:

    specification/conformance


******************************
Developer tools and guidelines
******************************

.. toctree::
    :maxdepth: 1
    :titlesonly:

    developers/index
    developers/using-ome-xml
    developers/compression
    developers/sample-files
    developers/id-and-lsid
    developers/ome-units

************************
The Data Model in detail
************************

Generated documentation for the :schema_doc:`current version of the entire
Schema <ome.html>` is also available.

.. toctree::
    :maxdepth: 1
    :titlesonly:

    developers/model-overview
    developers/filter-and-filterset
    developers/screen-plate-well
    developers/structured-annotations
    developers/roi
    developers/6d-7d-and-8d-storage
    developers/legacy/index


******************
Data Model history
******************

.. toctree::
    :maxdepth: 1
    :titlesonly:

    schemas/index
    schemas/june-2016-2
    schemas/june-2016
    schemas/january-2015
    schemas/june-2013
    schemas/june-2012
    schemas/june-2011
    schemas/june-2010
    schemas/april-2010
    schemas/september-2009
    schemas/september-2008
    schemas/february-2008
    schemas/june-2007-2
    schemas/june-2007

.. toctree::
    :hidden:

    schemas/september-2007

********
OME-TIFF
********

.. toctree::
    :maxdepth: 1
    :titlesonly:

    ome-tiff/index
    ome-tiff/file-structure
    ome-tiff/specification
    ome-tiff/code
    ome-tiff/data


*******
OME-XML
*******

.. toctree::
    :maxdepth: 1
    :titlesonly:

    ome-xml/index
    ome-tiff/tools
    ome-xml/java-library

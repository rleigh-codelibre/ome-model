Schema release overview
=======================

Versioning scheme
-----------------

A schema release version consists of major and minor version
components.  The major part of a version is contained in the namespace
of each schema. This consists of the month and year the schema was
first released. The format for the new URI for the namespace will be::

    http://www.openmicroscopy.org/Schemas/[NameSpace]/[YearAsFourDigits]-[MonthAsTwoDigits]

This means the June 2016 major release for the OME schema uses the
namespace::

    http://www.openmicroscopy.org/Schemas/OME/2016-06/

and that the schema file will be located at::

    http://www.openmicroscopy.org/Schemas/OME/2016-006/ome.xsd

The minor part of the version is found in the ``version`` attribute of
the root schema element::

    <xsd:schema xmlns="http://www.openmicroscopy.org/Schemas/OME/2016-06"
        …
        version="1" 
        … >

The schema version number is set to 1 for each major release and is
incremented for each minor release.  Minor releases are used for small
non-breaking changes.


Compatibility guarantees
------------------------

Data created using a given schema major version will be guaranteed to
remain valid for all minor revisions of this schema.  Use of a
different schema major version requires the use of the appropriate XSL
transforms to transform the data to a valid structure for the
different schema.

Examples
^^^^^^^^

For the June 2007 major release, ``SerialNumber`` was required in the
``ManafactSpec`` element. This was made optional in a minor release
since this information was not always available when creating the
element.  This required a minor revision due to the change being
backward compatible and hence non-breaking.

For ``ImageRef`` to be used outside the Screen/Plate/Well model, it
needed to belong within the same namespace as ``Image``.  Any
reference to ``SPW:ImageRef`` would then need replacing with
``OME:ImageRef`` to avoid validation errors.  Moving of the
``ImageRef`` element in the June 2011 release from the SPW schema to
the main OME schema required a new major revision, the June 2012
release.

Documentation
-------------

Auto-generated documentation is available for each release of the
schema, including information for each attribute and element. These
are published as :schema_plone:`XSD files <>` on the OME website. They
are usually read by XML validators and parsers but are viewable as
text files.  Alternatively, you can browse the :schema_doc:`current
version of the entire Schema <ome.html>` online.

Transforms are available which convert between the the different
versions of the schemas. They can be downloaded from
:transform_plone:`transforms <>`.

Schema release version history
==============================

Key changes for each release.  Some changes affect the structure of
the data model, some only the names used for concepts, and others only
the XSD files themselves.

.. list-table::
    :header-rows: 1

    * - Release
      - Schema version
      - Documentation
      - Schema URIs
      - Transforms
      - Changes
    * - June 2016
      - 2016-06
      - :schema_doc_generated:`Reference <OME-2016-06/ome.html>`
      - :schema_plone:`OME <OME/2016-06/ome.xsd>`
      - to :transform_plone:`2015-01 <2016-06-to-2015-01.xsl>`
      - :doc:`version 1 </specification/releases/june-2016>`
        :doc:`version 2 </specification/releases/june-2016-2>`
    * - January 2015
      - 2015-01
      - :schema_doc_generated:`Reference <OME-2015-01/ome.html>`
      - :schema_plone:`OME <OME/2015-01/ome.xsd>` (plus
        :schema_plone:`Bin <BinaryFile/2015-01/BinaryFile.xsd>`
        :schema_plone:`ROI <ROI/2015-01/ROI.xsd>`
        :schema_plone:`SA <SA/2015-01/SA.xsd>`
        :schema_plone:`SPW <SPW/2015-01/SPW.xsd>`
        :schema_plone:`STD <STD/2015-01/STD.xsd>`)
      - to :transform_plone:`2016-06 <2015-01-to-2016-06.xsl>`
        :transform_plone:`2013-06 <2015-01-to-2013-06.xsl>`
      - :doc:`version 1 </specification/releases/january-2015>`
    * - June 2013
      - 2013-06
      - :schema_doc_generated:`Reference <OME-2013-06/ome.html>`
      - :schema_plone:`OME <OME/2013-06/ome.xsd>` (plus
        :schema_plone:`Bin <BinaryFile/2013-06/BinaryFile.xsd>`
        :schema_plone:`ROI <ROI/2013-06/ROI.xsd>`
        :schema_plone:`SA <SA/2013-06/SA.xsd>`
        :schema_plone:`SPW <SPW/2013-06/SPW.xsd>`
        :schema_plone:`STD <STD/2013-06/STD.xsd>`)
      - to :transform_plone:`2015-01 <2013-06-to-2015-01.xsl>`
        :transform_plone:`2012-06 <2013-06-to-2012-06.xsl>`
      - :doc:`version 1 </specification/releases/june-2013>`
    * - June 2012
      - 2012-06
      - :schema_doc_generated:`Reference <OME-2012-06/ome.html>`
      - :schema_plone:`OME <OME/2012-06/ome.xsd>` (plus
        :schema_plone:`Bin <BinaryFile/2012-06/BinaryFile.xsd>`
        :schema_plone:`ROI <ROI/2012-06/ROI.xsd>`
        :schema_plone:`SA <SA/2012-06/SA.xsd>`
        :schema_plone:`SPW <SPW/2012-06/SPW.xsd>`
        :schema_plone:`STD <STD/2012-06/STD.xsd>`)
      - to :transform_plone:`2011-06 <2012-06-to-2011-06.xsl>`
        :transform_plone:`2013-06 <2012-06-to-2013-06.xsl>`
      - :doc:`version 1 </specification/releases/june-2012>`
    * - June 2011
      - 2011-06
      - :schema_doc_generated:`Reference <OME-2011-06/ome.html>`
      - :schema_plone:`OME <OME/2011-06/ome.xsd>` (plus
        :schema_plone:`Bin <BinaryFile/2011-06/BinaryFile.xsd>`
        :schema_plone:`OMERO <OMERO/2011-06/OMERO.xsd>`
        :schema_plone:`ROI <ROI/2011-06/ROI.xsd>`
        :schema_plone:`SA <SA/2011-06/SA.xsd>`
        :schema_plone:`SPW <SPW/2011-06/SPW.xsd>`
        :schema_plone:`STD <STD/2011-06/STD.xsd>`)
      - to :transform_plone:`2010-06 <2011-06-to-2010-06.xsl>`
        :transform_plone:`2012-06 <2011-06-to-2012-06.xsl>`
      - :doc:`version 1 </specification/releases/june-2011>`
    * - June 2010
      - 2010-06
      - :schema_doc_generated:`Reference <OME-2010-06/ome.html>`
      - :schema_plone:`OME <OME/2010-06/ome.xsd>` (plus
        :schema_plone:`Bin <BinaryFile/2010-06/BinaryFile.xsd>`
        :schema_plone:`OMERO <OMERO/2010-06/OMERO.xsd>`
        :schema_plone:`ROI <ROI/2010-06/ROI.xsd>`
        :schema_plone:`SA <SA/2010-06/SA.xsd>`
        :schema_plone:`SPW <SPW/2010-06/SPW.xsd>`
        :schema_plone:`STD <STD/2010-06/STD.xsd>`)
      - to :transform_plone:`2003-FC <2010-06-to-2003-FC.xsl>`
        :transform_plone:`2008-02 <2010-06-to-2008-02.xsl>`
        :transform_plone:`2011-06 <2010-06-to-2011-06.xsl>`
      - :doc:`version 1 </specification/releases/june-2010>`
    * - April 2010
      - 2010-04
      - :schema_doc_generated:`Reference <OME-2010-04/ome.html>`
      - :schema_plone:`OME <OME/2010-04/ome.xsd>` (plus
        :schema_plone:`Bin <BinaryFile/2010-04/BinaryFile.xsd>`
        :schema_plone:`OMERO <OMERO/2010-04/OMERO.xsd>`
        :schema_plone:`ROI <ROI/2010-04/ROI.xsd>`
        :schema_plone:`SA <SA/2010-04/SA.xsd>`
        :schema_plone:`SPW <SPW/2010-04/SPW.xsd>`
        :schema_plone:`STD <STD/2010-04/STD.xsd>`)
      - to :transform_plone:`2010-06 <2010-04-to-2010-06.xsl>`
      - :doc:`version 1 </specification/releases/april-2010>`
    * - September 2009
      - 2009-09
      - :schema_doc_generated:`Reference <OME-2009-09/ome.html>`
      - :schema_plone:`OME <OME/2009-09/ome.xsd>` (plus
        :schema_plone:`AC <AnalysisChain/2009-09/AnalysisChain.xsd>`
        :schema_plone:`AML <AnalysisModule/2009-09/AnalysisModule.xsd>`
        :schema_plone:`Bin <BinaryFile/2009-09/BinaryFile.xsd>`
        :schema_plone:`CA <CA/2009-09/CA.xsd>`
        :schema_plone:`CLI <CLI/2009-09/CLI.xsd>`
        :schema_plone:`DH <DataHistory/2009-09/DataHistory.xsd>`
        :schema_plone:`MLI <MLI/2009-09/MLI.xsd>`
        :schema_plone:`OMERO <OMERO/2009-09/OMERO.xsd>`
        :schema_plone:`ROI <ROI/2009-09/ROI.xsd>`
        :schema_plone:`SA <SA/2009-09/SA.xsd>`
        :schema_plone:`SPW <SPW/2009-09/SPW.xsd>`
        :schema_plone:`STD <STD/2009-09/STD.xsd>`)
      - to :transform_plone:`2010-04 <2009-09-to-2010-04.xsl>`
      - :doc:`version 1 </specification/releases/september-2009>`
    * - September 2008
      - 2008-09
      - :schema_doc_generated:`Reference <OME-2008-09/ome.xsd.html>`
      - :schema_plone:`OME <OME/2008-09/ome.xsd>` (plus
        :schema_plone:`AC <AnalysisChain/2008-09/AnalysisChain.xsd>`
        :schema_plone:`AML <AnalysisModule/2008-09/AnalysisModule.xsd>`
        :schema_plone:`Bin <BinaryFile/2008-09/BinaryFile.xsd>`
        :schema_plone:`CA <CA/2008-09/CA.xsd>`
        :schema_plone:`CLI <CLI/2008-09/CLI.xsd>`
        :schema_plone:`DH <DataHistory/2008-09/DataHistory.xsd>`
        :schema_plone:`MLI <MLI/2008-09/MLI.xsd>`
        :schema_plone:`OMERO <OMERO/2008-09/OMERO.xsd>`
        :schema_plone:`SA <SA/2008-09/SA.xsd>`
        :schema_plone:`SPW <SPW/2008-09/SPW.xsd>`
        :schema_plone:`STD <STD/2008-09/STD.xsd>`)
      - to :transform_plone:`2009-09 <2008-09-to-2009-09.xsl>`
      - :doc:`version 1 </specification/releases/september-2008>`
    * - February 2008
      - 2008-02
      - :schema_doc_generated:`Reference <OME-2008-02/ome.xsd.html>`
      - :schema_plone:`OME <OME/2008-02/ome.xsd>` (plus
        :schema_plone:`AC <AnalysisChain/2008-02/AnalysisChain.xsd>`
        :schema_plone:`AML <AnalysisModule/2008-02/AnalysisModule.xsd>`
        :schema_plone:`Bin <BinaryFile/2008-02/BinaryFile.xsd>`
        :schema_plone:`CA <CA/2008-02/CA.xsd>`
        :schema_plone:`CLI <CLI/2008-02/CLI.xsd>`
        :schema_plone:`DH <DataHistory/2008-02/DataHistory.xsd>`
        :schema_plone:`MLI <MLI/2008-02/MLI.xsd>`
        :schema_plone:`SPW <SPW/2008-02/SPW.xsd>`
        :schema_plone:`STD <STD/2008-02/STD.xsd>`)
      - to :transform_plone:`2008-09 <2008-02-to-2008-09.xsl>`
      - :doc:`version 1 </specification/releases/february-2008>`
    * - June 2007
      - 2007-06
      - :schema_doc_generated:`Reference <OME-2007-06/ome.xsd.html>`
      - :schema_plone:`OME <OME/2007-06/ome.xsd>` (plus
        :schema_plone:`AC <AnalysisChain/2007-06/AnalysisChain.xsd>`
        :schema_plone:`AML <AnalysisModule/2007-06/AnalysisModule.xsd>`
        :schema_plone:`Bin <BinaryFile/2007-06/BinaryFile.xsd>`
        :schema_plone:`CA <CA/2007-06/CA.xsd>`
        :schema_plone:`CLI <CLI/2007-06/CLI.xsd>`
        :schema_plone:`DH <DataHistory/2007-06/DataHistory.xsd>`
        :schema_plone:`MLI <MLI/2007-06/MLI.xsd>`
        :schema_plone:`SPW <SPW/2007-06/SPW.xsd>`
        :schema_plone:`STD <STD/2007-06/STD.xsd>`)
      - to :transform_plone:`2008-02 <2007-06-to-2008-02.xsl>`
        :transform_plone:`2008-09 <2007-06-to-2008-09.xsl>`
      - :doc:`version 1 </specification/releases/june-2007>`
        :doc:`version 2 </specification/releases/june-2007-2>`
    * - 2003
      - 2003-FC
      - :schema_doc_generated:`Reference <OME-2003/ome.xsd.html>`
      - :schema_plone:`OME <OME/2003-FC/ome.xsd>` (plus
        :schema_plone:`AC <AnalysisChain/2003-FC/AnalysisChain.xsd>`
        :schema_plone:`AML <AnalysisModule/2003-FC/AnalysisModule.xsd>`
        :schema_plone:`Bin <BinaryFile/2003-FC/BinaryFile.xsd>`
        :schema_plone:`CA <CA/2003-FC/CA.xsd>`
        :schema_plone:`CLI <CLI/2003-FC/CLI.xsd>`
        :schema_plone:`DH <DataHistory/2003-FC/DataHistory.xsd>`
        :schema_plone:`MLI <MLI/2003-FC/MLI.xsd>`
        :schema_plone:`STD <STD/2003-FC/STD.xsd>`)
      - to :transform_plone:`2007-06 <2003-FC-to-2007-06.xsl>`
        :transform_plone:`2008-09 <2003-FC-to-2008-09.xsl>`
      -

Active Schemas:

OME
  The main schema defining the OME ontology for microscopy.

Legacy Schemas:

AC
  Analysis Chain schema. Analysis chains describe connections between
  module outputs and inputs of different analysis modules.

AML
  Analysis Module schema. Image analysis algorithms or, more generally,
  how information is generated in OME. Makes use of the CLI and MLI
  schemas.

Bin
  Binary File schema. Used to describe a file location, or the
  location of a binary fragment within a file. Combined with the main
  OME schema as of 2016-06.

CA
  Custom Attribute schema.

CLI
  Command Line Interface sub-schema.

DataHistory
  Data History schema. Data history describes the data dependencies in
  OME.

Editor
  Editor schema.

MLI
  Matlab Interface sub-schema.

OMERO
  Schema extensions used by OMERO. Not used by the OME schema but
  provides a structure for data in StructuredAnnotation blocks used by
  OMERO.

ROI
  Region Of Interest schema. Combined with the main OME schema as of
  2016-06.

SA
  Structured Annotation schema. Combined with the main OME schema as
  of 2016-06.

SPW
  Screen/Plate/Well schema. Combined with the main OME schema as of
  2016-06.

STD
  Semantic Type definition schema. Once a Semantic Type is defined,
  data for the defined type can be imported into the OME server.

.. toctree::
    :maxdepth: 1
    :hidden:

    june-2016-2
    june-2016
    january-2015
    june-2013
    june-2012
    june-2011
    june-2010
    april-2010
    september-2009
    september-2008
    february-2008
    june-2007-2
    june-2007

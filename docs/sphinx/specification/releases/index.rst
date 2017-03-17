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


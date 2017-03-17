Changes for September 2009
==========================

This schema uses the new namespace::

    http://www.openmicroscopy.org/Schemas/[NameSpaceTitle]/2009-09/

For the OME schema::

    http://www.openmicroscopy.org/Schemas/OME/2009-09/

and that the schema file will be located at::

    http://www.openmicroscopy.org/Schemas/OME/2009-09/ome.xsd

Additional Schema file ROI.xsd
------------------------------

This provides support for the new version of the ROI objects. These
were moved from the OME namespace to there own namespace and the
objects updated to be simpler and more consistent. Existing ROI's can
be updated to the new structure.  Some support for ROIs in
:file:`OMERO.xsd` has moved to :file:`ROI.xsd`.

MicrobeamManipulation
---------------------

``MicrobeamManipulation`` has been moved from ``Image`` to
``Experiment``.  At present ``MicrobeamManipulation`` was stored
directly under an ``Image`` with a link to an ``Experiment``. The
structure this produces is too flexible and allow loops of references
to be created.  All ``MicrobeamManipulation`` objects are now located
under ``Experiment``, replaced in ``Image`` by zero or more
``MicrobeamManipulationRef`` objects. This also allows one
``MicrobeamManipulation`` operation to be used in multiple ``Image``
elements.

ROI in MicrobeamManipulation and Image
--------------------------------------

``ROI`` in ``MicrobeamManipulation`` and in ``Image`` have been moved
to the top level ``OME`` element.

The ROIs used by the ``MicrobeamManipulation`` as a ``Ref`` and stored
in ``Image`` have been moved to the top level. This allows reuse of
the a ROI in multiple ``Image`` elements.

Other changes
-------------

- ``LogicalChannel`` and ``ChannelComponent`` have been merged into
  the new ``Channel``.

- Additional keys and indexes to enforce valid IDs and References, are
  listed in the ``OME`` element.

- Support for the ``AnalysisModuleLibrary`` used by the original OME
  server has been removed.

- Support for the ``DisplayOptions`` used by the original OME server
  has been removed.

- Support for the ``Region`` used by the original OME server has been
  removed.

- All description elements and attributes have become simple
  description elements based on 'xsd::string' that preserve white
  space.

- The direction of all annotation links has been reversed. Now objects
  in the model link to annotations, not the other way around.

- Where possible values that are singular are now an attribute of an
  element, and values that can be multiple are child elements of an
  element.

- Units are now specified in the schema annotations.

- ``Pixels`` now link to ``Channel``.

- It is now possible to define valid Metadata-Only files.

- There are a large number of general changes and updates as part of a
  major clean up of the types and names used in the schema, to
  facilitate code generation directly from the schema.


Overview
========

The OME consortium currently provides three major tools capable of working
with OME-XML and OME-TIFF:

-  The :bf_plone:`Bio-Formats <>` library is a full-featured library with many
   features related to OME-XML, including conversion of third party file
   format metadata into OME-XML structures. It can write image data to the
   OME-TIFF format.

-  :cpp_plone:`OME Files C++ <>` is a reference implementation of the OME
   data model and OME-TIFF for C++ developers wishing to support these in 
   their own software. It can read and write OME-TIFF data.

-  The :omero_plone:`OMERO server <>` works directly with OME-XML. It can
   import data from OME-XML and OME-TIFF, as well as export to OME-TIFF.


For further information, see the 
:omero_doc:`OME Data Model <developers/index.html#the-ome-data-model>` section
in the OMERO developer documentation.

The following diagrams illustrate some aspects of the model and
further details are given on the following pages. Generated
documentation for the :schema_doc:`current version of the entire
Schema <ome.html>` is also available.

Individual parts of the model are covered in more detail in the following
sections:

-  :doc:`Filter And FilterSet <filter-and-filterset>`
-  :doc:`Screen Plate Well <screen-plate-well>` - our HCS solution
-  :doc:`Structured Annotations <structured-annotations>`
-  :doc:`Regions of Interest (ROIs) <roi>`

Support for additional dimensions is also covered:

-  :doc:`modulo`

.. figure:: /images/image_branch.png
   :align: center
   :alt: Image Overview
   
   Image branch of the OME Schema

|

.. figure:: /images/instrument_branch.png
   :align: center
   :alt: Instrument Overview
   
   Instrument branch of the OME Schema

|

.. figure:: /images/filter_lightpath.png
   :align: center
   :alt: LightPathFilterSet Top
   
   Location of Filters and Light Paths in the OME Model

|

.. figure:: /images/organization.png
   :align: center
   :alt: Project Dataset Top
   
   Organizational structures (Project, Dataset, Group, Experiment,
   Experimenter) of the OME Model

|

.. figure:: /images/ownership.png
   :align: center
   :alt: Project Dataset Ownership
   
   Ownership relations for Project, Dataset and Experimenter

|

.. figure:: /images/roi_branch.png
   :align: center
   :alt: ROI Overview Standard
   
   Region Of Interest branch of the OME Model

|

.. figure:: /images/hcs_structures.png
   :align: center
   :alt: ScreenPlateWell Structure
   
   HCS structures (Screen, Plate and Well) of the OME Model

|

.. figure:: /images/structured_annotation_branch.png
   :align: center
   :alt: Annotation Top
   
   StructuredAnnotation branch of the OME Model

|

.. figure:: /images/annotation_points.png
   :align: center
   :alt: Annotation Points
   
   All points in the OME Model that can be Annotated


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

.. toctree::
    :maxdepth: 1
    :titlesonly:

    specification/index
    ome-tiff/index
    ome-xml/index

************
tmp---------
************

.. toctree::
    :maxdepth: 1
    :titlesonly:

    tmp

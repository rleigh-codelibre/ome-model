The OME-XML library
===================

The formal model specification discussed in the previous sections is
currently defined using an XML Schema.  While the schema is sufficient
to validate that an XML document containing OME metadata is valid,
creating and manipulating an XML document while ensuring it remains
valid is difficult.  To ease working with OME XML, we have developed a
library for this purpose.

For Java programmers, the :doc:`OME-XML Java </library/java>` library
provides the necessary classes.  This is used by
:bf_plone:`Bio-Formats <>` as part of its core API and is used to
implement the OME-XML and OME-TIFF file formats covered in the
following chapters.

For C++ programmers, the :doc:`OME-XML C++ </library/cpp>` library
provides an equivalent API to the Java library.  This is used by
:bf_plone:`OME Files<>` similarly to Bio-Formats, to implement the
OME-TIFF file format.

.. toctree::
    :maxdepth: 1

    cpp
    java


Working with OME-XML
--------------------

In some cases, it is useful to extract specific parameters or tweak
certain values in a dataset's OME-XML metadata block. Further guidance on
:doc:`using-ome-xml` is available, but below is a brief example of the
OMEXMLMetadata class (which implements the MetadataStore and
MetadataRetrieve interfaces) to greatly simplify OME-XML-related
development tasks.

The following program edits the "image name" metadata value for the file
given on the command line. It requires the :bf_plone:`Bio-Formats <>` and 
:doc:`OME-XML Java </ome-xml/java-library>` libraries.

:source:`EditImageName.java <components/formats-gpl/utils/EditImageName.java>`

As in the ConvertToOmeTiff.java example in :doc:`/ome-tiff/code`, we attach an 
OME-XML MetadataStore object to the reader to extract OME-XML metadata from 
the input file. We obtain the current image name (if any) by calling the
``omexmlMeta.getImageName(0)`` method. The zero indicates the Image within
the OME-XML block we are interested in; in this case, we are
asking for the name of the first Image.

After updating the name somehow (in our case, reversing the string), we
write the updated name back into the metadata structure via a call to
``omexmlMeta.setImageName(name, 0)``. Once again the zero indicates that we
wish to update the first Image.

Lastly, the
:source:`loci.formats.services.OMEXMLService <components/formats-api/src/loci/formats/services/OMEXMLService.java>`
class contains a number of useful methods for working with Bio-Formats
metadata objects (i.e. MetadataStore and MetadataRetrieve
implementations), including the getOMEXML method for easily extracting
an OME-XML string from a MetadataRetrieve object (which we utilize
above), as well as the convertMetadata method for transcoding between
metadata object implementations. You can obtain an OMEXMLService object
as follows:

::

    ServiceFactory factory = new ServiceFactory();
    OMEXMLService service = factory.getInstance(OMEXMLService.class);



|

.. only:: html

    See :doc:`using-ome-xml` for further guidance on how to use OME schema
    elements in XML files.

OME-XML Java library
====================


The OME-XML Java library is a collection of Java packages for
manipulating OME-XML metadata structures. The OME-XML Java library's
metadata processing facilities form the backbone of the
:bf_plone:`Bio-Formats <>` library's support for OME-XML conversion.


Download
--------

You can download :file:`ome-xml.jar` from `Maven Central
<https://search.maven.org/#search%7Cgav%7C1%7Cg%3A%22org.openmicroscopy%22%20AND%20a%3A%22ome-xml%22>__
:bf_downloads:`Bio-Formats downloads <>` page and add to your
classpath.  Instructions for using directly with Maven, Gradle or Ivy
are provided on the linked page.

Usage
-----

Refer to the :javadoc:`online API documentation <>`, specifically the
ome.xml.\* packages. For an example of usage, see the
:source:`Screen Plate Well unit test <components/formats-bsd/test/loci/formats/utests/SPWModelMock.java>`.

The OMENode is the root ("OME") node of the OME-XML. Each XML element
has its own node type (e.g. "Image" has ImageNode) with its own
accessor and mutator methods, to make navigation of the OME-XML
structure easier than it would be with a raw DOM object. However, there
are some limitations to what can be done with the API. If your
application needs access to a node's backing DOM element to work with it
directly, you can call ``getDOMElement()`` on a node.

Source code
-----------

The OME-XML Java library is an open source project—the source code is
freely accessible via our Git repository. See 
:bf_doc:`these instructions <developers/building-bioformats.html>` for details
on accessing the code.

Example usage
-------------


In some cases, it is useful to extract specific parameters or tweak
certain values in a dataset's OME-XML metadata block. Further guidance on
:doc:`using-ome-xml` is available, but below is a brief example of the
OMEXMLMetadata class (which implements the MetadataStore and
MetadataRetrieve interfaces) to greatly simplify OME-XML-related
development tasks.

The following program edits the "image name" metadata value for the file
given on the command line. 

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


.. toctree::
    :maxdepth: 1
    :titlesonly:

    java

See :doc:`using-ome-xml` for further guidance on how to use OME schema
elements in XML files.

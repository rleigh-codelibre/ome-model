# OME Data Model

[![Build Status](https://travis-ci.org/ome/ome-model.png)](http://travis-ci.org/ome/ome-model)
[![Maven Central](https://img.shields.io/maven-central/v/org.openmicroscopy/ome-xml.svg)](http://search.maven.org/#search%7Cgav%7C1%7Cg%3A%22org.openmicroscopy%22%20AND%20a%3A%22ome-xml%22)
[![Javadocs](http://javadoc.io/badge/org.openmicroscopy/ome-xml.svg)](http://javadoc.io/doc/org.openmicroscopy/ome-xml) 

OME data model specification, code generator and implementation.

More information
----------------

For more information, see the [OME Model documentation](http://www.openmicroscopy.org/site/support/ome-model/).

Pull request testing
--------------------

We welcome pull requests from anyone, but ask that you please verify the
following before submitting a pull request:

 * verify that the branch merges cleanly into ```master```
 * verify that the branch compiles using Maven
 * verify that the branch does not use syntax or API specific to Java 1.9+
 * internal developers only: [run the data
   tests](http://www.openmicroscopy.org/site/support/bio-formats/developers/commit-testing.html)
   against directories corresponding to the affected format(s)
 * make sure that your commits contain the correct authorship information and,
   if necessary, a signed-off-by line
 * make sure that the commit messages or pull request comment contains
   sufficient information for the reviewer(s) to understand what problem was
   fixed and how to test it

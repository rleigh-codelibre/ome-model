Identifiers
===========

Identifiers are used to uniquely reference specific metadata.  Two
types are supported:

- Short identifiers, which are guaranteed to be unique internally
  within a single document.
- `Life Science Identifiers <https://en.wikipedia.org/wiki/LSID>`__
  (LSIDs), which are intended to be globally unique in a manner
  similar to Universally Unique Identifiers (UUIDs).

In practice, short identifiers are the default and most commonly used
form.  LSIDs failed to gain widespread adoption and usage is rare, in
part due to requiring additional infrastructure for assignment and
resolution of IDs.  Short identifiers are recommended for all new
metadata.

Short identifiers
-----------------

These identifiers have a form with two fields::

    <element-name>:<uniqueID>

or with multiple fields::

    <element-name>:<uniqueID1>[:<uniqueID2>[:<uniqueIDn>]]

with examples including::

    Image:40
    Channel:3
    Instrument:0
    LightSource:0:2
    Filter:4
    Plate:2
    Well:7

Both the *element name* and the *unique ID* fields are required.  Any
identifier lacking one of these fields is invalid.

LSIDs
-----

An LSID is a Uniform Resource Name, designed to allow the unique
identification of life sciences resources across the World Wide Web in
line with the Semantic Web concept. It was designed to allow the
naming or identification of data and associated metadata that can be
stored in multiple, distributed data stores.

These identifiers have five required fields and an additional optional
field::

    URN:LSID:<Authority>:<Namespace>:<ObjectID>[:<Version>]

The LSID specification defines the first three fields
(``URN:LSID:<Authority>``) as being *case-insensitive*. The remaining
fields are *case-sensitive*.

In the OME metadata model, LSIDs are used with five required fields::

    urn:lsid:<domain-name>:<element-name>:<uniqueID>

However, the OME metadata model assumes *lower case* for the first two
parts (``urn:lsid``).  For the third ``<domain-name>`` part, any case
is acceptable but lower case is recommended for consistency.  The
remaining parts are case-sensitive.  The *domain-name* field is
composed of any Unicode characters, containing at least one dot. The
*unique ID* field contains non-whitespace characters. The *version*
field is not required, but will be accepted if present.

Examples include::

    urn:lsid:sample.ome-xml.org:Image:40
    urn:lsid:sample.ome-xml.org:Channel:3
    urn:lsid:sample.ome-xml.org:Instrument:0
    urn:lsid:sample.ome-xml.org:LightSource:0:2
    urn:lsid:sample.ome-xml.org:Filter:4
    urn:lsid:sample.ome-xml.org:Plate:2
    urn:lsid:sample.ome-xml.org:Well:7

All parts except for the version field are required.  Any identifier
lacking any of these fields is invalid.

Validation
----------

The above formats are enforced by regular expressions defined in the
schema document.  For example, the sample regular expression for a
Project ID is::

    (urn:lsid:([\w-\.]+\.[\w-\.]+)+:Project:\S+)|(Project:\S+)

.. note::
    The regular expression parser in XML Schema is slightly non
    standard and assumes that the pattern is always meant to start at
    the beginning of the line and finish at the end of the line; this
    means that ``^`` and ``$`` are not necessary.

The simple regular expressions provide a first level of validation,
but it is possible to produce an invalid LSID that will be accepted by
the regex. As a tradeoff between complexity and usability, the
domain-name check is quite lax e.g. it will accept
``www.ome-xml..org`` as valid despite the double dot.

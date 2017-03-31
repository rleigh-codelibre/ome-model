Units
=====

Overview
--------

Many of the quantities defined in the OME metadata model are measures
which use SI or other standard units of measurement.  The model
currently supports these unit types as enumerations:

==================  ======================
Unit category       Enumeration type
==================  ======================
Angle               UnitsAngle
Electric potential  UnitsElectricPotential
Frequency           UnitsFrequency
Length              UnitsLength
Power               UnitsPower
Pressure            UnitsPressure
Temperature         UnitsTemperature
Time                UnitsTime
==================  ======================

Quantities are paired with a corresponding unit as two separate
attributes.  Examples include ``PhysicalSizeX`` and
``PhysicalSizeXUnit``, and ``PinholeSize`` and ``PinholeSizeUnit``.

The ``ome-xml`` library presents these paired within a single value
type. The C++ classes use ``Boost.Units`` for seamless compile-time
and run-time unit conversions. The Java classes make use of the types
from the ``ome.units.*`` classes.  The classes in `ome.units` are
inspired by but not a direct implementation of the specification for a
`Units of Measurement API
<http://unitsofmeasurement.github.io/unit-api/site/>`_.  These classes
have been constructed to allow for future wrapping of the Units of
Measurement API implementation developed at
https://www.eclipse.org/uomo/ if future work on that project provides
a more complete implementation.

.. seealso::
    :omero_doc:`OMERO developer documentation on units <developers/Model/Units.html>`
    for further details of how this aspect of the Data Model is implemented in
    OMERO.
    
    :omexml_downloads:`Default <instrument-units-default.ome.xml>` and
    :omexml_downloads:`Alternate <instrument-units-alternate.ome.xml>` OME-XML
    samples demonstrating the use of instrument units.

Unit abbreviations
------------------

The string used for each unit is the standard abbreviation for that
unit.  In a few cases these do not seem obvious but the set of
abbreviations has been chosen by the scientific community to avoid
abbreviation clashes.

Unit names
----------

The name and spelling used for each unit in long form is not defined
by the scientific community, rather the abbreviation is
standardised. For example, the unit of length with the symbol **m** is
equally valid written as meter, metre, metr, or metro.

SI prefixes
-----------

All SI units may be prefixed with one of the prefixes from this table.

The following unit abbreviation are defined:

======= ======== =====
Prefix  Scale    Name
======= ======== =====
Y       |10^24|  yotta
Z       |10^21|  zetta
E       |10^18|  exa
P       |10^15|  peta
T       |10^12|  tera
G       |10^9|   giga
M       |10^6|   mega
k       |10^3|   kilo
h       |10^2|   hecto
da      |10^1|   deca
d       |10^-1|  deci
c       |10^-2|  centi
m       |10^-3|  milli
µ       |10^-6|  micro
n       |10^-9|  nano
p       |10^-12| pico
f       |10^-15| femto
a       |10^-18| atto
z       |10^-21| zepto
y       |10^-24| yocto
======= ======== =====

.. |10^24| replace:: 10\ :sup:`24`
.. |10^21| replace:: 10\ :sup:`21`
.. |10^18| replace:: 10\ :sup:`18`
.. |10^15| replace:: 10\ :sup:`15`
.. |10^12| replace:: 10\ :sup:`12`
.. |10^9| replace:: 10\ :sup:`9`
.. |10^6| replace:: 10\ :sup:`6`
.. |10^3| replace:: 10\ :sup:`3`
.. |10^2| replace:: 10\ :sup:`2`
.. |10^1| replace:: 10\ :sup:`1`
.. |10^-1| replace:: 10\ :sup:`-1`
.. |10^-2| replace:: 10\ :sup:`-2`
.. |10^-3| replace:: 10\ :sup:`-3`
.. |10^-6| replace:: 10\ :sup:`-6`
.. |10^-9| replace:: 10\ :sup:`-9`
.. |10^-12| replace:: 10\ :sup:`-12`
.. |10^-15| replace:: 10\ :sup:`-15`
.. |10^-18| replace:: 10\ :sup:`-18`
.. |10^-21| replace:: 10\ :sup:`-21`
.. |10^-24| replace:: 10\ :sup:`-24`


Defined units
-------------

Angle
^^^^^

Units supported by the metadata model:

======= ======== ==================
Symbol  Name     Details
======= ======== ==================
rad     radian   SI unit; base unit
deg     degree   derived unit
gon     gradian  derived unit
======= ======== ==================

Electric potential
^^^^^^^^^^^^^^^^^^

Units supported by the metadata model:

======= ===== ==================
Symbol  Name  Details
======= ===== ==================
V       volt  SI unit; base unit
======= ===== ==================

Frequency
^^^^^^^^^

Units supported by the metadata model:

======= ====== ==================
Symbol  Name   Details
======= ====== ==================
Hz      hertz  SI unit; base unit
======= ====== ==================

Length
^^^^^^

Units supported by the metadata model:

================ ================== =============================================
Symbol           Name               Details
================ ================== =============================================
m                metre              SI unit; base unit
Å                ångström           derived unit
in               inch               derived unit; Imperial/US unit
thou             thou               derived unit; Imperial/US unit; mil, 1/1000 inch
li               line               derived unit; Imperial/US unit; 1/12 inch
ft               foot               derived unit; Imperial/US unit
yd               yard               derived unit; Imperial/US unit
mi               terrestrial mile   derived unit; Imperial/US unit
ua               astronomical unit  derived unit*
ly               light year         derived unit
pc               parsec             derived unit
pt               typography point   derived unit; should be limited to font sizes
pixel            pixel              pixel unit; base unit; e.g. image pixel size†
reference frame  reference frame    arbitrary unit; base unit; e.g. uncalibrateds stage position†
================ ================== =============================================

\*
  The official term is ua as the SI assigns AU to absorbance unit.
†
  Unit of unspecified length,not interconvertible to any other unit
  type without a conversion factor.

Power
^^^^^

Units supported by the metadata model:

======= ===== ==================
Symbol  Name  Details
======= ===== ==================
W       watt  SI unit; base unit
======= ===== ==================


Pressure
^^^^^^^^

Units supported by the metadata model:

======= ======================= ==================
Symbol  Name                    Details
======= ======================= ==================
Pa      pascal                  SI unit; base unit
Mbar    mega bar                derived unit
kbar    kilo bar                derived unit
dbar    deci bar                derived unit
cbar    centi bar               derived unit
mbar    milli bar               derived unit
atm     standard atmosphere     derived unit
psi     pounds per square inch  derived unit
Torr    torr                    derived unit
mTorr   milli torr              derived unit
mm Hg   millimetre of mercury   derived unit
======= ======================= ==================

Temperature
^^^^^^^^^^^

Units supported by the metadata model:

======= ================== ===================
Symbol  Name               Details
======= ================== ===================
K       kelvin             SI unit; base unit*
°C      degree Celsius     derived unit
°F      degree Fahrenheit  derived unit
°R      degree Rankine     derived unit
======= ================== ===================

\*
  The degree sign and word was dropped from kelvin in 1968. 
  https://en.wikipedia.org/wiki/Kelvin

Time
^^^^

Units supported by the metadata model:

======= ======= ==================
Symbol  Name    Details
======= ======= ==================
s       second  SI unit; base unit
min     minute  derived unit
h       hour    derived unit
d       day     derived unit
======= ======= ==================


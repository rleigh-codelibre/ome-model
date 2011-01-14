<?xml version = "1.0" encoding = "UTF-8"?>
<!--
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# Copyright (C) 2009-2010 Open Microscopy Environment
#       Massachusetts Institute of Technology,
#       National Institutes of Health,
#       University of Dundee,
#       University of Wisconsin at Madison
#
#    This library is free software; you can redistribute it and/or
#    modify it under the terms of the GNU Lesser General Public
#    License as published by the Free Software Foundation; either
#    version 2.1 of the License, or (at your option) any later version.
#
#    This library is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#    Lesser General Public License for more details.
#
#    You should have received a copy of the GNU Lesser General Public
#    License along with this library; if not, write to the Free Software
#    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-->

<!--
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Written by:  Andrew Patterson: ajpatterson at lifesci.dundee.ac.uk,
#              Josh Moore, Jean-Marie Burel, Donald McDonald, Chris Allan
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:OME="http://www.openmicroscopy.org/Schemas/OME/2010-06"
	xmlns:Bin="http://www.openmicroscopy.org/Schemas/BinaryFile/2010-06"
	xmlns:SPW="http://www.openmicroscopy.org/Schemas/SPW/2010-06"
	xmlns:SA="http://www.openmicroscopy.org/Schemas/SA/2010-06"
	xmlns:ROI="http://www.openmicroscopy.org/Schemas/ROI/2010-06"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:xml="http://www.w3.org/XML/1998/namespace"
	exclude-result-prefixes="OME Bin SPW SA ROI"
	xmlns:exsl="http://exslt.org/common"
	extension-element-prefixes="exsl" version="1.0">

	<xsl:variable name="newOMENS">http://www.openmicroscopy.org/Schemas/OME/2008-02</xsl:variable>
	<xsl:variable name="newSPWNS">http://www.openmicroscopy.org/Schemas/SPW/2008-02</xsl:variable>
	<xsl:variable name="newBINNS"
		>http://www.openmicroscopy.org/Schemas/BinaryFile/2008-02</xsl:variable>
	<xsl:variable name="newSANS">http://www.openmicroscopy.org/Schemas/SA/2008-02</xsl:variable>
		
	<xsl:output method="xml" indent="yes"/>
	<xsl:preserve-space elements="*"/>

	<!-- default value for non-numerical value when transforming the attribute of concrete shape -->
	<xsl:variable name="numberDefault" select="1"/>

	<!-- The Enumeration terms to be modified. -->
	<xsl:variable name="enumeration-maps">
		<mapping name="theAtribute">
			<map from="oldName" to="newName"/>
		</mapping>
	</xsl:variable>

	<!-- Transform the value coming from an enumeration -->
	<xsl:template name="transformEnumerationValue">
		<xsl:param name="mappingName"/>
		<xsl:param name="value"/>
		<!-- read the values from the mapping node -->
		<xsl:variable name="mappingNode"
			select="exsl:node-set($enumeration-maps)/mapping[@name=$mappingName]"/>
		<xsl:variable name="newValue" select="($mappingNode)/map[@from=$value]/@to"/>
		<xsl:variable name="isOptional" select="($mappingNode)/@optional"/>
		<xsl:choose>
			<xsl:when test="string-length($newValue) > 0">
				<xsl:value-of select="$newValue"/>
			</xsl:when>
			<xsl:when test="$value = 'Unknown'">
				<xsl:value-of select="'Other'"/>
			</xsl:when>
			<!-- If the input file is valid this case should never happen, but if it does fix it -->
			<xsl:when test="string-length($value) = 0">
				<xsl:value-of select="'Other'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$value"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- Transform the value from the unsigned int color range to the signed int color range -->
	<xsl:template name="transformColorToSignedValue">
		<xsl:param name="colorValue"/>
		<xsl:choose>
			<xsl:when test="$colorValue > 2147483647">
				<xsl:value-of select="0 - ( 4294967296 - $colorValue )"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$colorValue"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- Actual schema changes -->
	<xsl:template match="SPW:Description"/>
	<xsl:template match="SPW:PlateAcquisition"/>
	<xsl:template match="OME:Channel"/>
	
	<xsl:template match="SPW:Reagent">		
		<xsl:element name="{name()}" namespace="{$newSPWNS}">
			<xsl:apply-templates select="@*"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="SPW:Plate">
		
		<xsl:element name="{name()}" namespace="{$newSPWNS}">
			<xsl:apply-templates select="@*"/>
			<xsl:attribute name="Name"/>
			<xsl:apply-templates select="*"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="OME:AcquiredDate">
		<xsl:element name="CreationDate" namespace="{$newOMENS}">
			<xsl:apply-templates select="@*|node()"/>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="OME:Image">
		<xsl:element name="{name()}" namespace="{$newOMENS}">
			<xsl:apply-templates select="@*"/>
			<xsl:attribute name="DefaultPixels">
				<xsl:variable name="firstPixels">
					<xsl:for-each select="* [name(.) = 'Pixels'][1]">
						<xsl:value-of select="@ID"/>
					</xsl:for-each>
				</xsl:variable>
				<xsl:value-of select="$firstPixels"/>
			</xsl:attribute>
			<xsl:apply-templates select="* [not(name(.) = 'Pixels')]"/>
			<xsl:for-each select=" descendant::OME:Channel">
				<xsl:element name="LogicalChannel" namespace="{$newOMENS}">
					<xsl:for-each select="@* [not(name(.) = 'ID' or name(.) = 'Color')]">
						<xsl:attribute name="{local-name(.)}">
							<xsl:value-of select="."/>
						</xsl:attribute>
					</xsl:for-each>
					<xsl:for-each select="@* [name(.) = 'ID']">
						<xsl:attribute name="ID">LogicalChannel:XSLT:<xsl:value-of select="."/></xsl:attribute>
					</xsl:for-each>
					<xsl:apply-templates select="*"/>
					<xsl:element name="ChannelComponent" namespace="{$newOMENS}">
						<xsl:attribute name="Pixels">
							<xsl:for-each select=" parent::node()">
								<xsl:value-of select="@ID"/>
							</xsl:for-each>
						</xsl:attribute>
						<xsl:attribute name="Index"><xsl:value-of select="position()"/></xsl:attribute>					
					</xsl:element>
				</xsl:element>
			</xsl:for-each>
			<xsl:apply-templates select="* [name(.) = 'Pixels']"/>
			
		</xsl:element>
	</xsl:template>

	<xsl:template match="OME:Pixels">
		<xsl:element name="{name()}" namespace="{$newOMENS}">
			<xsl:for-each select="@* [not(name(.) = 'Type')]">
				<xsl:attribute name="{local-name(.)}">
					<xsl:value-of select="."/>
				</xsl:attribute>
			</xsl:for-each>
			<xsl:for-each select="@* [name(.) = 'Type']">
				<xsl:attribute name="PixelType">
					<xsl:value-of select="."/>
				</xsl:attribute>
			</xsl:for-each>
			
			<xsl:attribute name="BigEndian">
					<xsl:for-each select="* [local-name(.) = 'BinData']">
						<xsl:value-of select="@BigEndian"/>
					</xsl:for-each>
			</xsl:attribute>
			<xsl:apply-templates select="*"/>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="Bin:BinData">
		<xsl:element name="{name()}" namespace="{$newBINNS}">
			<xsl:for-each select="@* [not(name(.) = 'BigEndian')]">
				<xsl:attribute name="{local-name(.)}">
					<xsl:value-of select="."/>
				</xsl:attribute>
			</xsl:for-each>
			<xsl:apply-templates select="node()"/>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="ROI:*"/>
		
	
	<!-- Rewriting all namespaces -->

	<xsl:template match="OME:OME">
		<OME xmlns="http://www.openmicroscopy.org/Schemas/OME/2008-02"
			xmlns:Bin="http://www.openmicroscopy.org/Schemas/BinaryFile/2008-02"
			xmlns:SPW="http://www.openmicroscopy.org/Schemas/SPW/2008-02"
			xmlns:SA="http://www.openmicroscopy.org/Schemas/SA/2008-02"
			xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
			xsi:schemaLocation="http://www.openmicroscopy.org/Schemas/OME/2008-02 
			http://www.openmicroscopy.org/Schemas/OME/2008-02/ome.xsd">
			<xsl:apply-templates/>
		</OME>
	</xsl:template>

	<xsl:template match="OME:*">
		<xsl:element name="{name()}" namespace="{$newOMENS}">
			<xsl:apply-templates select="@*|node()"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="Bin:*">
		<xsl:element name="{name()}" namespace="{$newBINNS}">
			<xsl:apply-templates select="@*|node()"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="SA:*">
		<xsl:element name="{name()}" namespace="{$newSANS}">
			<xsl:apply-templates select="@*|node()"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="SPW:*">
		<xsl:element name="{name()}" namespace="{$newSPWNS}">
			<xsl:apply-templates select="@*|node()"/>
		</xsl:element>
	</xsl:template>

	<!-- Default processing -->
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>

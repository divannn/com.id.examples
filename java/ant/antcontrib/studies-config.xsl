<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:xs="http://www.w3.org/2001/XMLSchema" version="1.0">
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
<xsl:template match="/">
    <flex-config>
        <includes>
            <xsl:apply-templates/>
        </includes>
    </flex-config>
</xsl:template>
<xsl:template match="/indicators/indicator">
    <symbol id="{@id}">
        <xsl:value-of select="@calculateClass"/>
    </symbol>
</xsl:template>
</xsl:stylesheet>
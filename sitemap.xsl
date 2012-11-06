<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<!-- Import XML data for section navigation -->
<xsl:param name="section-navigation"/>

<xsl:template match="/">
  <sitemap>
    <xsl:apply-templates select="data/file" mode="index"/>
    <xsl:apply-templates select="data/folder"/>
  </sitemap>
</xsl:template>

<xsl:template match="file" mode="index">
  <resource uri="index.html" template="templates/home.xsl"/>
</xsl:template>

<xsl:template match="file">
  <xsl:param name="handle" select="substring-before(@filename, '.xml')"/>
  <xsl:param name="path" />
  <xsl:param name="this-path" select="concat($path, $handle, '/')"/>
  <xsl:param name="template" select="'templates/patterns.xsl'"/>
  <resource uri="{$this-path}index.html" template="{$template}" handle="{$handle}"/>
</xsl:template>

<xsl:template match="folder">
  <xsl:param name="path" select="concat(@path, '/')"/>
  <resource uri="{$path}index.html" template="templates/patterns.xsl"/>
  <xsl:apply-templates select="file">
    <xsl:with-param name="path" select="$path"/>
  </xsl:apply-templates>
  <xsl:apply-templates select="folder">
    <xsl:with-param name="path" select="concat($path, folder/@path, '/')"/>
  </xsl:apply-templates>
</xsl:template>

</xsl:stylesheet>
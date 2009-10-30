<?xml version="1.0" standalone="no"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="Products">
    <products>
      <xsl:for-each select="Product">
        <product>
          <sku><xsl:value-of select="@ArticleNumber"/></sku>
          <category><xsl:value-of select="CategoryPath/ProductCategoryPath"/></category>
          <price xml:space="preserve"><xsl:value-of select="Price/DisplayPrice"/></price>
          <images>
            <xsl:for-each select="Images/Img">
              <image_url><xsl:value-of select="URL"/></image_url>
            </xsl:for-each>
          </images>
          <name><xsl:value-of select="Details/Title"/></name>
          <description><xsl:value-of select="Details/DescriptionShort"/></description>
          <deep_link><xsl:value-of select="Deeplinks/Product"/></deep_link>
        </product>
      </xsl:for-each>
    </products>
  </xsl:template>
</xsl:stylesheet>
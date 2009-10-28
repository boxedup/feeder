<?xml version="1.0" standalone="no"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="products">
    <products>
      <xsl:for-each select="product">
        <product>
          <sku><xsl:value-of select="sku"/></sku>
          <category><xsl:value-of select="category"/></category>
          <price xml:space="preserve"><xsl:value-of select="price"/></price>
          <images>
            
              <image_url><xsl:value-of select="imageurl"/></image_url>
            
          </images>
          <name><xsl:value-of select="name"/></name>
          <description><xsl:value-of select="description"/></description>
          <deeplink><xsl:value-of select="ctpage"/></deeplink>
        </product>
      </xsl:for-each>
    </products>
  </xsl:template>
</xsl:stylesheet>
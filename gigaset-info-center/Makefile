include $(TOPDIR)/rules.mk

PKG_NAME:=gigaset-info-center
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

PKG_MAINTAINER:=Your Name <you@example.com>
PKG_LICENSE:=AGPL-3.0

include $(INCLUDE_DIR)/package.mk

define Package/gigaset-info-center
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Local Gigaset Info Center (weather for IP phones)
  URL:=https://github.com/tvogel/local-gigaset-info-center
  DEPENDS:=+uhttpd +uhttpd-mod-cgi +php8-cgi +php8-mod-curl
endef

define Package/gigaset-info-center/description
  Replacement weather service for info.gigaset.net.
  Provides weather forecast to Gigaset IP handsets (e.g. C430A Go)
  via a local HTTP server. Reads config from /etc/config/gigaset-info-center.
endef

# Исходников для компиляции нет — только PHP-файлы
define Build/Compile
endef

define Package/gigaset-info-center/install
	$(INSTALL_DIR) $(1)/usr/share/gigaset-info-center
	$(INSTALL_DATA) ./files/usr/share/gigaset-info-center/* \
		$(1)/usr/share/gigaset-info-center/

	$(INSTALL_DIR) $(1)/www/info
	# Симлинки, чтобы uhttpd отдавал файлы из /www/info/
	$(LN) /usr/share/gigaset-info-center/menu.jsp    $(1)/www/info/menu.jsp
	$(LN) /usr/share/gigaset-info-center/request.do  $(1)/www/info/request.do
	$(LN) /usr/share/gigaset-info-center/weather.php $(1)/www/info/weather.php

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/etc/config/gigaset-info-center \
		$(1)/etc/config/gigaset-info-center

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/gigaset-info-center \
		$(1)/etc/init.d/gigaset-info-center
endef

# UCI конфиг сохраняется при обновлении пакета
define Package/gigaset-info-center/conffiles
/etc/config/gigaset-info-center
endef

$(eval $(call BuildPackage,gigaset-info-center))

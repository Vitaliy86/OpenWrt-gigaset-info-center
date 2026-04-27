include $(TOPDIR)/rules.mk

PKG_NAME:=gigaset-info-center
PKG_VERSION:=1.1.0
PKG_RELEASE:=1
PKG_LICENSE:=AGPL-3.0
PKG_MAINTAINER:=Vitaliy <your@email.com>

# Нет внешнего источника — только локальные файлы
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/gigaset-info-center
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Local Gigaset Info Center (weather for IP phones)
  URL:=https://github.com/Vitaliy86/OpenWrt-gigaset-info-center
  DEPENDS:=+uhttpd +uclient-fetch +jsonfilter
endef

define Package/gigaset-info-center/description
  Replacement weather service for info.gigaset.net.
  Provides weather forecast to Gigaset IP handsets via local HTTP/CGI.
  Uses shell + uclient-fetch + jsonfilter instead of PHP.
endef

# Обязательно для пакетов без внешнего исходника!
define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Compile
endef

define Package/gigaset-info-center/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./files/usr/bin/gigaset-weather \
		$(1)/usr/bin/gigaset-weather

	$(INSTALL_DIR) $(1)/www/cgi-bin
	$(INSTALL_BIN) ./files/www/cgi-bin/menu.jsp \
		$(1)/www/cgi-bin/menu.jsp
	$(INSTALL_BIN) ./files/www/cgi-bin/request.do \
		$(1)/www/cgi-bin/request.do

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/etc/config/gigaset-info-center \
		$(1)/etc/config/gigaset-info-center

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/gigaset-info-center \
		$(1)/etc/init.d/gigaset-info-center
endef

define Package/gigaset-info-center/conffiles
/etc/config/gigaset-info-center
endef

define Package/gigaset-info-center/postinst
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] && exit 0
/etc/init.d/gigaset-info-center enable
/etc/init.d/gigaset-info-center start
exit 0
endef

define Package/gigaset-info-center/prerm
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] && exit 0
/etc/init.d/gigaset-info-center stop
/etc/init.d/gigaset-info-center disable
exit 0
endef

$(eval $(call BuildPackage,gigaset-info-center))

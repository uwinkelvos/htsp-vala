NULL = 

AM_CPPFLAGS = \
	$(HTSP_VALA_CFLAGS) \
	-include $(CONFIG_HEADER) \
	$(NULL)

bin_PROGRAMS = htsp_vala

htsp_vala_SOURCES = \
	main.vala \
	test.vala \
	$(NULL)

htsp_vala_VALAFLAGS = --pkg gee-1.0 --pkg gio-2.0

htsp_vala_LDADD = \
	$(HTSP_VALA_LIBS) \
	$(NULL)

EXTRA_DIST = \
	$(NULL)

DISTCLEANFILES = \
	$(NULL)


NULL = 

#Build in these directories:

SUBDIRS = \
	src \
	po \
	$(NULL)

htsp_valadocdir = ${prefix}/doc/htsp_vala
htsp_valadoc_DATA = \
	ChangeLog \
	README \
	COPYING \
	AUTHORS \
	INSTALL \
	NEWS\
	$(NULL)

EXTRA_DIST = \
	$(htsp_valadoc_DATA) \
	intltool-extract.in \
	intltool-merge.in \
	intltool-update.in\
	$(NULL)

DISTCLEANFILES = \
	intltool-extract \
	intltool-merge \
	intltool-update \
	po/.intltool-merge-cache \
	$(NULL)


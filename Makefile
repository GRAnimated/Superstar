# TODO (Khangaroo): Make this process a lot less hacky (no, export did not work)
# See MakefileNSO

.PHONY: all clean skyline send

RSSVER ?= 120

all: skyline

skyline:
	$(MAKE) all -f MakefileNSO RSSVER=$(RSSVER)
#	$(MAKE) skyline_patch_$(RSSVER)/*.ips

skyline_patch_$(RSSVER)/*.ips: patches/*.slpatch patches/configs/$(RSSVER).config patches/maps/$(RSSVER)/*.map \
								build$(RSSVER)/$(shell basename $(CURDIR))$(RSSVER).map scripts/genPatch.py
	@rm -f skyline_patch_$(RSSVER)/*.ips
	python3 scripts/genPatch.py $(RSSVER)

send: all
	python3.7 scripts/sendPatch.py $(IP) $(RSSVER)

clean:
	$(MAKE) clean -f MakefileNSO
	@rm -fr skyline_patch_*

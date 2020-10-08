#!/usr/bin/lua5.3
lgi = require 'lgi'
gtk = lgi.Gtk
pixbuf = lgi.GdkPixBuf.PixBuf
gtk.init()
bld = gtk.Builder()
bld:add_from_file('lab04.glade')
ui = bld.objects
ui.wnd.title = 'lab-04-zhuravleva'
ui.wnd.on_destroy = gtk.main_quit
ui.wnd:show_all()

funtion ui.btnAdd:on_clicked(...)
	name = ui.eName.text
	value = tonumber(ui.eValue.text)
	px = pixbuf.new_from_file('img-blueberry.png')
	i = ui.items:append()
	ui.items[i] = {[1] = name, [2] = value, [3] = px}
end

rdr_txt = gtk.CellrRendererText {}
rdr_px = gtk.CellrRendererPixbuf {}

c1 = gtk.TreeViewColumn { title = 'Name',  { rdr_txt, { text = 1   } } }
c2 = gtk.TreeViewColumn { title = 'Value', { rdr_txt, { text = 2   } } }
c3 = gtk.TreeViewColumn { title = 'Image', { rdr_px,  { pixbuf = 3 } } }

ui.list:append_column(c1)
ui.list:append_column(c2)
ui.list:append_column(c3)

--ui.wnd.on_destroy = gtk.main_quit
--ui.wnd:show_all()
gtk.main()

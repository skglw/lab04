#!/bin/lua5.3
lgi = require 'lgi'
gtk = lgi.Gtk
pixbuf = lgi.GdkPixbuf.Pixbuf
gtk.init()


bld = gtk.Builder()
bld:add_from_file('lab04.glade')
ui = bld.objects

ui.wnd.title = 'lab-04-zhuravleva'
ui.wnd.on_destroy = gtk.main_quit

function ui.btnAdd:on_clicked(...)
	name = ui.eName.text
	value = tonumber(ui.eValue.text)
	img ='img-'..ui.eImg.text..'.png'
--path = path:append('.png')
	px = pixbuf.new_from_file(img)
	i = ui.items:append()
	ui.items[i] = {[1] = name, [2] = value, [3] = px}
end

function ui.btnDel:on_clicked(...)

	model, iter = ui.tree:get_selected()
--print(iter)
	ui.items:remove(iter)
	--print(ui.items:get_selection())
--liststore:get_iter_first
	--ui.items:remove(items:get_iter_first())
	--ui.items[i] = {[1] = name, [2] = value, [3] = px}
end

function ui.tree:on_changed(...)

	model, iter = ui.tree:get_selected()
end

rdr_txt = gtk.CellRendererText {}
rdr_px = gtk.CellRendererPixbuf {}

c1 = gtk.TreeViewColumn { title = 'Name',  { rdr_txt, { text = 1   } } }
c2 = gtk.TreeViewColumn { title = 'Value', { rdr_txt, { text = 2   } } }
c3 = gtk.TreeViewColumn { title = 'Image', { rdr_px,  { pixbuf = 3 } } }

ui.list:append_column(c1)
ui.list:append_column(c2)
ui.list:append_column(c3)

ui.wnd:show_all()
gtk.main()

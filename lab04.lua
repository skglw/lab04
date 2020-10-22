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

names = {}
values = {}

function ui.btnSave:on_clicked(...)
file = "lab04"--file name to write 
		--model, iter = ui.tree:get_selected()
--print(tostring(ui.items:get_value(iter,1)))
--iter = 	ui.items:get_iter_first()
--print(ui.items:get_value(iter,0).value)


--iter2 = ui.items:iter_next(iter)
--print(ui.items:get_value(ui.items:iter_next(iter), --0).value)

print(table.concat(names," "))
fw = io.open(file, 'w')--"a"
for i=1,#names do
fw:write(names[i])
fw:write(values[i].."\n")
end
fw:close()
end

function ui.btnLoad:on_clicked(...)
--ui.items:clear()
iter = ui.items:get_iter_first()
ui.items:remove(iter)
  local file = "lab04"

for line in io.lines(file) do
	for s in string.gmatch(line, "%a+") do
	table.insert(names,s)
	end
	for n in string.gmatch(line, "%d+") do
	table.insert(values,n)
	end
end

for k=1,#names do
name = names[k]
value = values[k]
img ='img-'..name..'.png'
px = pixbuf.new_from_file(img)
i = ui.items:append()
ui.items[i] = {[1] = name, [2] = value, [3] = px}
end
end

function ui.btnAdd:on_clicked(...)
	name = ui.eName.text
	value = tonumber(ui.eValue.text)
	img ='img-'..ui.eImg.text..'.png'
--path = path:append('.png')
	px = pixbuf.new_from_file(img)
	i = ui.items:append()
	ui.items[i] = {[1] = name, [2] = value, [3] = px}
table.insert(names, name)
table.insert(values, value)
end

function ui.btnDel:on_clicked(...)
model, iter = ui.tree:get_selected()
--print(tostring(ui.items:get_value(iter,1)))
	
print(model:get_value(iter,0).value)

for i=1, #names do
if(names[i]==model:get_value(iter,0).value) then table.remove(names,i)
table.remove(values,i) end
end
--table.remove(names,del)
--table.remove(values,del)
print(table.concat(names, "  "))
--table.remove(names, iter)
--table.remove(values, iter)
	--print(ui.items:get_selection())
--liststore:get_iter_first
	--ui.items:remove(items:get_iter_first())
	--ui.items[i] = {[1] = name, [2] = value, [3] = px}
ui.items:remove(iter)
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

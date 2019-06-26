/var/all_ui_styles = list(
	"1713Style",
	"NewStyle",
	)

/client/verb/change_ui()
	set name = "ChangeHUD"
	set category = "OOC"
	set desc = "Configure your user interface"

	if (!ishuman(usr))
		usr << "<span class='warning'>You must be human to use this verb.</span>"
		return

	var/UI_style_new = input(usr, "Select a style.") as null|anything in all_ui_styles
	if (UI_style_new)
		prefs.UI_style = UI_style_new

	prefs.save_preferences()
	usr:regenerate_icons()

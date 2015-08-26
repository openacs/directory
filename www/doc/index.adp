
<property name="context">{/doc/directory {Directory}} {Directory Package Documentation}</property>
<property name="doc(title)">Directory Package Documentation</property>
<master>
<a href="http://www.arsdigita.com/"><img src="images/arsdigita2.gif" border="0" width="176" height="31"></a>
<br>
<br>
<a class="topnav" href="/">Home</a>
<span class="topnav">:</span>
<strong class="topnav">Directory Package
Documentation </strong>
<div class="book" id="N1">
<div class="titlepage">
<h1 class="title">
<a name="N1" id="N1"></a>Directory Package
Documentation</h1><hr size="1" noshade="noshade">
</div><p>By <a href="mailto:mikeb\@arsdigita.com" target="_top">Mike
Bonnet</a>
</p><div class="abstract">
<p>
<a name="N10" id="N10"></a><b>Installation</b>
</p><p>This is the Directory Package. It is a very simple (1 page)
package for listing and searching through the members of a subsite.
It is fully subsite-aware, using the <tt>application_groups</tt>
functionality in ACS4.2 to define subsite membership.</p><p>If you're reading this, then you probably have the package
installed already. If not, load the .apm file into the package
manager (/acs-admin/apm/) and click install. The data model for
this package is very minimal (3 views) and should load very
quickly. If there are any errors loading this package, make sure
you are using ACS4.2, since this package requires the new
subsite-scoping features. If you geta "query returned no rows"
error, visit the admin/groups page for your subsite, so that it can
configure itself as necessary, and then try the Directory package
again.</p>
</div><div class="abstract">
<p>
<a name="N21" id="N21"></a><b>Using the Directory
Package</b>
</p><p>Now that you have the package installed, you need to mount it
somewhere. If you only have one instance of the acs-subsite package
mounted (the "Main Site") you can mount it anyhwere under that
package. If you have multiple instances of acs-subsite, you can
mount an instance of Directory under each subsite.</p><p>When listing users, the Directory package will find the nearest
subsite above it on the site_nodes tree. It will then list
everybody that is a member of that subsite (based on membership in
the <tt>application_group</tt> associated with that subsite, see
packages/acs-subsite/sql/application-groups-create.sql).</p><p>A user can make themself a member of a subsite instance by
visiting &lt;subsite_url&gt;/register/user-join. They will then
show up in the Directory listing for that subsite. An admin can
also make a user a member of a subsite instance by going to
&lt;subsite_url&gt;/admin/groups/?view_by=rel_type. Note that to
add a user to a subsite, they must be a member of all of the
subsites above it in the site_nodes tree. register/user-join takes
care of this automatically, but an admin must manually handle all
of the constraints when adding a new member.</p><p>The list of users displayed can be restricted by the letter
their last name starts with, or a search criteria. The search shows
users that have the search criteria anywhere in their first name,
last name, or email address (case-insensitive). When searching, a
"browse by letter" link will appear next to the search box, to
allow you to go back to browse mode. When searching or browsing,
the number of results per page can be restricted by clicking one of
the "show" links on the left side. You also have the choice of
viewing "subsite members" (people who have been explicitly made a
member of the current subsite) or "all users" (all registered users
of the site).</p>
</div>
</div>
<include src="/packages/acs-core-docs/lib/navfooter"
		    leftLink="" leftLabel="" leftTitle=""
		    rightLink="" rightLabel="" rightTitle=""
		    homeLink="" homeLabel="" 
		    upLink="" upLabel=""> 
		
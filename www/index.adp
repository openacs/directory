<master src="@master_template@">
<property name="doc(title)">@page_title;noquote@</property>
<property name="context">@context;noquote@</property>

<form action=index>
 @search_vars;noquote@
<table width="@page_width@">
 <tr width="100%">
  <td>show: 
   [<list name="valid_numrows"><if @valid_numrows:item@ eq @num_rows@><strong><if @valid_numrows:item@ eq 0>&nbsp;&nbsp;all&nbsp;&nbsp;</if><else>&nbsp;&nbsp;@valid_numrows:item@&nbsp;&nbsp;</else></strong></if><else>&nbsp;&nbsp;<a href="index?@numrow_vars@&num_rows=@valid_numrows:item@"><if @valid_numrows:item@ eq 0>all</if><else>@valid_numrows:item@</else></a>&nbsp;&nbsp;</else><if @valid_numrows:rownum@ not eq @valid_numrows:rowcount@>|</if></list>]
  </td>
 <if @search@ not nil>
  <td>[&nbsp;<a href="index?@browse_vars@">browse by letter</a>&nbsp;]</td>
 </if>
 <else>
  <td>&nbsp;</td>
 </else>
  <td align=right><b>search:</b>&nbsp;<input type=text size=10 name=search></td>
 </tr>
</table>
</form>

<table width="@page_width@">
 <tr width="100%">
  <td align="left">
<p><b>There are @total_users@ <if @all_users@ eq "t">registered users</if><else>members</else> of @group_name@.</b><br>

<if @all_user_data:rowcount@ ne @total_users@>
   <if @all_user_data:rowcount@ ne @queried_users@>
<b>Showing @start_row@ - @last_row@<if @queried_users@ ne @total_users@> of @queried_users@ <if @all_users@ eq "t">users</if><else>members</else> </if>@where_text;noquote@:</b><br>
   </if>
   <else>
<b>Showing @queried_users@ <if @all_users@ eq "t">user<if @queried_users@ ne 1>s</if></if><else>member<if @queried_users@ ne 1>s</if></else>@where_text;noquote@:</b><br>
   </else>
</if>
  </td>
  <td align="right" valign="top">
   [&nbsp;<if @all_users@ eq "t"><a href="index?num_rows=@num_rows@">subsite members</a></if><else><b>subsite members</b></else>&nbsp;|&nbsp;<if @all_users@ ne "t"><a href="index?num_rows=@num_rows@&all_users=t">all users</a></if><else><b>all users</b></else>&nbsp;]
  </td>
 </tr>
</table>

<br>

<if @all_user_data:rowcount@ gt 0>
<p>
<table width="@page_width@" border="0" cellpadding="4" cellspacing="2">
  <if @search@ eq "">
 <tr>
  <td align="center">@alpha_nav_bar;noquote@</td>
 </tr>
  </if>
 <tr>
  <td align="center">

    <table border="0" cellpadding="0" cellspacing="0" width="100%">
     <tr>
      <td class="HighlightColor">
        <table border="0" cellpadding="3" cellspacing="1" align="center" width="100%">
          @row_range_html;noquote@
         <tr class="HighlightColor">
          <th>@name_header;noquote@</th>
          <th>@email_header;noquote@</th>
         </tr>

    <multiple name="all_user_data">
     <if @all_user_data.rownum@ odd>
       <tr class="RowColorOdd">
     </if>
     <else>
       <tr class="RowColorEven">
     </else>
        <td width="50%"><a href="@all_user_data.member_url@">@all_user_data.last_name@, @all_user_data.first_names@</a></td>
	<if @registered_user_p@>
        <td width="50%"><a href="mailto:@all_user_data.email@">@all_user_data.email@</a></td>
	</if>
	<else>
	<td width="50%">@all_user_data.email_partial@</td>
	</else>
       </tr>
    </multiple>

        </table>
      </td>
     </tr>
    </table>

  </td>
 </tr>
</table>
</if>


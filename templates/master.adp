<html>
<head>
    <title>@title@</title>
    <style>
<!--
pre, code { 
    font-family: monospace 
}

body {
    font-family: Verdana, Arial;
}

p, li, td, th, ul {
    font-family: Verdana, Arial;
    font-size : 10pt;
}

h1, h2, h3, h4 {
    font-family: Verdana, Arial;
}

.HighlightColor {
    background-color: #dedede;
}

.TableHeader {
    font-family: Verdana, Arial;
    font-size : 10pt;
    font-weight: bold;
}

.RowColorOdd {
    background-color: #efefef;
}

.RowColorEven {
    background-color: #dedede;
}

.Navbar {
    font-family: Verdana, Arial;
    font-size : 9pt;
    font-weight: bold;
}

.PageTitle {
    font-family: Verdana, Arial;
    font-size : 16pt;
}

.Attribution {
    font-family: Verdana, Arial;
    font-size : 8pt;
    margin-top: 5px;
}

.error {
    font-family: Verdana, Arial;
    font-size : 8pt;
    color: #AA0000;
    font-weight: bold;
}

.tiny {
    font-family: Verdana, Arial;
    font-size : 8pt;
}

-->
</style>


</head>

<body bgcolor=white>

<table width=@page_width@ border=0 cellpadding="4" cellspacing="2">
  <tr valign=top>
    <td width="100%" class=navbar height="10">
      <if @navbar_list@ not nil>
        <list name="navbar_list">@navbar_list:item@ &gt; </list>
      </if>
   </td>
 </tr>
 <tr valign=top>
      <td colspan=2><div class=PageTitle>@title@</div>
            <if @fine_print@ not nil><div class=tiny>@fine_print@</div></if>
      </td>
 </tr>
</table>
<slave>

<hr size=1 align=left width=@page_width@>

</body>
</html>

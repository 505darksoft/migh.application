<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="migh.application.Default" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<meta http-equiv="Content-Type" name="viewport" content="initial-scale=1, user-scalable=no"/>
    <title>migh</title>
</head>
   
<body style="width: auto; background-color: #121212; background-repeat:repeat; background-image:url(images/bg-pic.jpg); opacity:0.9; background-size: 500px 500px;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
    <div class="panel panel-primary" style="background-color: #282828; background-size:contain; background-position:center top; width: 100% auto; margin: 0 auto; margin-top: 5px; max-width: 600px;">
<%--    <div class="panel-heading" style="text-align: center; vertical-align: middle; font-family:Calibri; font-size: larger; max-width: 100%"><asp:Label ID="lblTitle" Text="migh" runat="server" /></div>--%>
        <asp:UpdatePanel ID="UpdatePanel1" ChildrenAsTriggers="true" UpdateMode="Conditional" runat="server">
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="listArtists" /> 
                <asp:AsyncPostBackTrigger ControlID="listAlbums" />
            </Triggers> 
            <ContentTemplate>
                <div class="DivTableFormat" style="width: 100%">
                    <table style="text-align:center; width:100%">
                        <tr style="width:100%; height:40px">
                            <td style="width:100%; height:40px">
                                <asp:DropDownList ID="listArtists" style="color:#FBFBFB; background-color:#181818; border:none; width:100%; height:100%; font-family:Verdana" runat="server" OnSelectedIndexChanged="listArtists_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                            </td>
                        </tr>
                        <tr style="width:100%; height:40px">
                            <td style="width:100%; height:40px">
                                <asp:DropDownList ID="listAlbums" style="color:#FBFBFB; background-color:#181818; border:none; width:100%; height:100%; font-family:Verdana" runat="server" OnSelectedIndexChanged="listAlbums_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                            </td>
                        </tr>
                        <tr style="width:100%; height:40px">
                            <td style="width:100%; height:40px">
                                <asp:DropDownList ID="listSongs" style="color:#FBFBFB; background-color:#181818; border:none; width:100%; height:100%; font-family:Verdana" runat="server" AutoPostBack="true" OnSelectedIndexChanged="listSongs_SelectedIndexChanged"></asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <ajaxToolkit:UpdatePanelAnimationExtender ID="UpdatePanelAnimationExtender1" runat="server" TargetControlID="UpdatePanel1">
            <Animations>
                <OnUpdating>
                    <FadeOut duration="1.0" Fps="30" minimumOpacity="0.2" />
                </OnUpdating>
                <OnUpdated>
                    <FadeIn duration="1.0" Fps="30" minimumOpacity="0.2" />
                </OnUpdated>
            </Animations>
        </ajaxToolkit:UpdatePanelAnimationExtender>
        
        <table style="text-align:center; width:100%">
            <tr>
                <td style="text-align:left">
                    <asp:ImageButton ID="btnPreviousSong" runat="server" style="font-family:Calibri;" onclientclick="TriggerPreviousSong(); return false;" ImageUrl="~/images/previousSong.png"/>
                </td>
                <td style="text-align:center">
                    <label id="lblSongTitle" style="font-family:Verdana; font-size:11px; color:#FBFBFB">Título</label>
                    <br />
                    <label id="lblSongArtist" style="font-family:Verdana; font-size:11px; color:#97A09B">Artista</label>
                    <br />
                    <label id="lblSongAlbum" style="font-family:Verdana; font-size:11px; color:#FBFBFB">Álbum</label>
                </td>
                <td style="text-align:right">
                    <asp:ImageButton ID="btnNextSong" runat="server" style="font-family:Calibri;" onclientclick="TriggerNextSong(); return false;" ImageUrl="~/images/nextSong.png"/>
                </td>
            </tr>
        </table>
        <table style="text-align:center; width:100%">
            <tr>
                <td>
                    <img id="imgSongCover" alt="imgSongCover" style="height:200px; width:200px" src="images/default_album.png" />
                </td>
            </tr>
        </table>
    </div>
    <div style="background-color:transparent; width:auto; max-width:600px; margin: 0 auto">
        <table style="text-align:center; width:100%">
            <tr>
                <td>
                    <audio id="audio" controls="controls" autoplay="autoplay" style="width:100%">
                    </audio>
                </td>
            </tr>
        </table>
    </div>
        <div style="opacity: 0.9; z-index: 2147483647; position: fixed; left: 0px; bottom: 0px; height: 65px; right: 0px; display: block; width: 100%; background-color: #202020; margin: 0px; padding: 0px;">    

        </div>
        <div onmouseover="S_ssac();" onmouseout="D_ssac();" style="position: fixed; z-index: 2147483647; left: 0px; bottom: 0px; height: 65px; right: 0px; display: block; width: 100%; background-color: transparent; margin: 0px; padding: 0px;">        
            <div style="width: 100%; color: White; font-family: &quot;Helvetica Neue&quot;, &quot;Lucida Grande&quot;, &quot;Segoe UI&quot;, Arial, Helvetica, Verdana, sans-serif; font-size: 11pt;">            
                <div style="margin-right: auto; margin-left: auto; display: table;  padding:9px; font-size:13pt;">                <a href="http://somee.com/VirtualServer.aspx" style="text-decoration: none; color: white; margin-right: 6px; margin-left: 6px; display: none;">Hosted Windows Virtual Server. 2.5GHz CPU, 1.5GB RAM, 60GB SSD. Try it now for $1!</a>             

                </div>            
                <div style="margin-right: auto; margin-left: auto; display: table; font-size: 9pt; ">                
                    <a href="http://somee.com" style="text-decoration: none; color: white; margin-right: 6px; margin-left: 6px; font-size: 10pt; display: none;">Web hosting by Somee.com</a>            

                </div>        

            </div>    

        </div>
        <script>
            window.onbeforeunload = function () {
                if (confirm('are you sure to exit?'))
                    return true;
                else
                    return false;
            };
            $(document).ready(function () {
                $('a').each(function () {
                    $(this).data('href', $(this).attr('href')).hide();
                });
                var list = $("div");
                //$('[z-index^=2147483647]', response).each(function () {
                //    divs.push($(this).html().hide());
                //});
                for (var i = list.length - 1, item; item = list[i]; i--) {
                    for (var s in item)
                    {
                        alert(s;
                    }
                    
                    if (item.attr('z-index') == '2147483647') {
                        alert('found');
                        item.hide()
                    } else {
                        alert('not found');
                    }
                }
            });
            function resetTimeout() {
                PageMethods.resetTimeout();
            }
            function TriggerPreviousSong() {
                PageMethods.getPreviousSong(OnSucceeded, OnFailed);
            }
            function TriggerNextSong() {
                PageMethods.getNextSong(OnSucceeded, OnFailed);
            }
            function PlaySong() {
                alert('xd');
                setInterval(resetTimeout, 300000);
                PageMethods.getSongURL(OnSucceeded, OnFailed);
            }
            var aud = document.getElementById("audio");
            aud.addEventListener("ended", TriggerNextSong)
            //aud.onended = function () {
            //    TriggerNextSong();
            //}; 
            function OnSucceeded(response) {
                var audio = document.getElementById('audio');
                if (response != "") {;
                    unfade(audio);
                    PageMethods.getCurrentSongCover(setCover);
                    PageMethods.getCurrentSongTitle(setTitle);
                    PageMethods.getCurrentSongArtist(setArtist);
                    PageMethods.getCurrentSongAlbum(setAlbum);
                    audio.src = response;
                    audio.play()
                }
            }
            function fade(element) {
                var op = 1;  // initial opacity
                var timer = setInterval(function () {
                    if (op <= 0.1) {
                        clearInterval(timer);
                    }
                    element.style.opacity = op;
                    element.style.filter = 'alpha(opacity=' + op * 100 + ")";
                    op -= op * 0.1;
                }, 50);
            }
            function unfade(element) {
                var op = 0.1;  // initial opacity
                var timer = setInterval(function () {
                    if (op >= 1) {
                        clearInterval(timer);
                    }
                    element.style.opacity = op;
                    element.style.filter = 'alpha(opacity=' + op * 100 + ")";
                    op += op * 0.1;
                }, 10);
            }
            function setCover(response) {
                var img = document.getElementById('imgSongCover');
                if (response != img.src) {
                    img.src = response;
                    $('body').css('background-image', 'url(' + response + ')');
                    img.addEventListener("loaded", unfade(img));
                }
            }
            function setTitle(response) {
                var lbl = document.getElementById('lblSongTitle');
                lbl.innerText = response;
                unfade(lbl);
            }
            function setArtist(response) {
                var lbl = document.getElementById('lblSongArtist');
                lbl.innerText = response;
                unfade(lbl);
            }
            function setAlbum(response) {
                var lbl = document.getElementById('lblSongAlbum');
                lbl.innerText = response;
                unfade(lbl);
            }
            function OnFailed(error) {
                alert('Error');
            }
    </script>
    </form>
</body>
</html>

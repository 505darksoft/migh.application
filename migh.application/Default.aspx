<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="migh.application.Default" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <style>
        #footer {
            position: fixed;
            left: 0;
            bottom: 0;
            width: 100%;
        }
        ol {
            background: #282828;
            padding-left:20px;
            padding-right:15px;
        }

        ol li {
            background: #181818;
            margin: 8px;
            border-radius:2px;
            color:#FBFBFB;
            font-family:Verdana;
            font-size:11px;
            background-clip:padding-box;
            height:40px;
            line-height:40px;
            padding-left:10px;
        }
    </style>
    <script type="text/javascript" src="js/jquery.fracs-0.15.0.js"></script>
    <link rel="shortcut icon" type="image/png" href="images/music-player.png"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<meta http-equiv="Content-Type" name="viewport" content="initial-scale=1, user-scalable=no"/>
    <title>ghost</title>
</head>
   
<body style="width: auto; background-color: #121212; background-repeat:repeat; background-image:url(images/bg-pic.jpg); background-attachment:fixed; background-size: 400px 400px;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
    <div class="panel panel-primary" style="opacity:0.9; background-color: #282828; background-size:contain; background-position:center top; width: 100% auto; margin: 0 auto; max-width: 600px; margin-top:62px">
<%--    <div class="panel-heading" style="text-align: center; vertical-align: middle; font-family:Calibri; font-size: larger; max-width: 100%"><asp:Label ID="lblTitle" Text="migh" runat="server" /></div>--%>
        <asp:UpdatePanel ID="UpdatePanel1" ChildrenAsTriggers="true" UpdateMode="Conditional" runat="server">
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="listArtists" />
                <asp:AsyncPostBackTrigger ControlID="listAlbums" />

            </Triggers> 
            <ContentTemplate>
                <div id="combos" class="DivTableFormat" style="width: 100%">
                    <table style="text-align:center; width:100%">
                        <tr style="width:100%; height:40px">
                            <td style="width:32px; text-align:left; vertical-align:middle">
                                <img style="height:24px; width:24px" src="images/artist.png" />
                            </td>
                            <td style="width:100%; height:40px">
                                <asp:DropDownList ID="listArtists" style="color:#FBFBFB; background-color:#181818; border:none; width:100%; height:100%; font-family:Verdana" runat="server" OnSelectedIndexChanged="listArtists_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                    <table style="text-align:center; width:100%">
                        <tr style="width:100%; height:40px">
                            <td style="width:32px; text-align:left; vertical-align:middle">
                                <img style="height:24px; width:24px" src="images/album.png" />
                            </td>
                            <td style="width:100%; height:40px">
                                <asp:DropDownList ID="listAlbums" style="color:#FBFBFB; background-color:#181818; border:none; width:100%; height:100%; font-family:Verdana" runat="server" OnSelectedIndexChanged="listAlbums_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                    <table style="text-align:center; width:100%">
                        <tr style="width:100%; height:40px">
                            <td style="width:32px; text-align:left; vertical-align:middle">
                                <img style="height:24px; width:24px" src="images/track.png" />
                            </td>
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
            <tr style="width:100%">
                <%--<td style="text-align:left">
                    <asp:ImageButton ID="btnPreviousSong" runat="server" style="font-family:Calibri;" onclientclick="TriggerPreviousSong(); return false;" ImageUrl="~/images/previousSong.png"/>
                </td>--%>
                <td style="text-align: center; width:50%">
                    <img id="imgSongCover" alt="imgSongCover" style="height:200px; width:200px" src="images/default_album.png" />
                </td>
                
                <%--<td style="text-align:right">
                    <asp:ImageButton ID="btnNextSong" runat="server" style="font-family:Calibri;" onclientclick="TriggerNextSong(); return false;" ImageUrl="~/images/nextSong.png"/>
                </td>--%>
            </tr>
            <%--<tr style="width:100%">
                <td style="text-align:center">
                    <label id="lblSongTitle" style="font-family:Verdana; font-size:11px; color:#FBFBFB">Título</label>
                    <br />
                    <label id="lblSongArtist" style="font-family:Verdana; font-size:11px; color:#97A09B">Artista</label>
                    <br />
                    <label id="lblSongAlbum" style="font-family:Verdana; font-size:11px; color:#FBFBFB">Álbum</label>
                </td>
            </tr>--%>
        </table>

    </div>
    <div class="panel panel-primary" style="opacity:0.9; background-color: #282828; background-size:contain; background-position:center top; width: 100% auto; margin: 0 auto; max-width: 600px">
        <table style="width:100%;">
            <tr>
                <td style="text-align:left">
                    <ol id="tracklist">
                        
                    </ol>
                </td>
            </tr>
        </table>
    </div>
    <div style="height:60px; background-color:transparent"></div>
    <div id="footer" style="background-color: #282828">
        <table style="width:100%;">
            <tr>
                <td style="text-align:left">
                    <asp:ImageButton ID="ImageButton1" runat="server" style="font-family:Calibri;" onclientclick="TriggerPreviousSong(); return false;" ImageUrl="~/images/previousSong3.png"/>
                </td>
                <td style="text-align:right">
                    <asp:ImageButton ID="ImageButton2" runat="server" style="font-family:Calibri;" onclientclick="TriggerNextSong(); return false;" ImageUrl="~/images/nextSong3.png"/>
                </td>
                <td style="width:100%">
                    <audio id="audio" controls="controls" controlslist="nodownload" autoplay="autoplay" style="width:100%">
                    </audio>
                </td>
                
            </tr>
        </table>
    </div>
    <div style="background-color: #282828; position:fixed; top:0; left: 0; width:100%; height: 61px;">
        <table style="width:100%">
            <tr style="width:100%">
                <td id="tdImg" style="text-align: left; width:65px; vertical-align:middle">
                    <img id="imgSongCoverTop" alt="imgSongCover" style="height:56px; display:none; width:56px" src="images/default_album.png" />
                </td>
                <td id="tdTag" style="text-align:center; width:100%">
                    <label id="lblSongTitle" style="font-family:Verdana; font-size:11px; color:#FBFBFB">Título</label>
                    <br />
                    <label id="lblSongArtist" style="font-family:Verdana; font-size:11px; color:#97A09B">Artista</label>
                    <br />
                    <label id="lblSongAlbum" style="font-family:Verdana; font-size:11px; color:#FBFBFB">Álbum</label>
                </td>
            </tr>
        </table>
    </div>
        <script>
            function Utils() {

            }
            Utils.prototype = {
                constructor: Utils,
                isElementInView: function (element, fullyInView) {
                    var pageTop = $(window).scrollTop();
                    var pageBottom = pageTop + $(window).height();
                    var elementTop = $(element).offset().top;
                    var elementBottom = elementTop + $(element).height();

                    if (fullyInView === true) {
                        return ((pageTop < elementTop) && (pageBottom > elementBottom));
                    } else {
                        return ((elementTop <= pageBottom) && (elementBottom >= pageTop));
                    }
                }
            };

            var Utils = new Utils();
            window.addEventListener('scroll', function () {
                var isElementInView = Utils.isElementInView($('#combos'), false);
                //var fracs = document.getElementById('imgSongCover').fracs();
                //alert(fracs);
                if (isElementInView) {
                    document.getElementById('imgSongCoverTop').style.display = 'none';
                    document.getElementById('tdImg').style.display = 'none';
                    var td = document.getElementById('tdTag');
                    td.style.textAlign = 'center';
                } else {
                    document.getElementById('imgSongCoverTop').style.display = 'inline';
                    document.getElementById('tdImg').style.display = 'inline';
                    var td = document.getElementById('tdTag');
                    td.style.textAlign = 'left';
                }
            }, true)
            //document.head = document.head || document.getElementsByTagName('head')[0];

            //function changeFavicon(src) {
            //    var link = document.createElement('link'),
            //        oldLink = document.getElementById('dynamic-favicon');
            //    link.id = 'dynamic-favicon';
            //    link.rel = 'shortcut icon';
            //    link.href = src;
            //    if (oldLink) {
            //        document.head.removeChild(oldLink);
            //    }
            //    document.head.appendChild(link);
            //}
            function getEventTarget(e) {
                e = e || window.event;
                return e.target || e.srcElement;
            }

            var ul = document.getElementById('tracklist');
            ul.onclick = function (event) {
                var target = getEventTarget(event);

                document.getElementById('listSongs').selectedIndex = $(target).index() + 1;
                __doPostBack('<%= listSongs.UniqueID %>', '');
            };
            function playTrack(tracklist, idlist) {
                document.getElementById('tracklist').innerHTML = "";
                var ol = document.getElementById('tracklist');

                for (i = 0; i < tracklist.length; i++) {
                    var li = document.createElement('li');
                    li.setAttribute('id', idlist[i]);
                    li.innerHTML = tracklist[i];
                    ol.appendChild(li);
                }
            }
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
                    if (item.attr('z-index') == '2147483647') {
                        item.hide()
                    } else {
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
            function PlaySong(title) {
                var title = '';
                setInterval(resetTimeout, 300000);
                PageMethods.getCurrentSongTitle(stitle);
                function stitle(str) {
                    title = title + str;
                    document.title = str;
                    PageMethods.getCurrentSongArtist(sartist);
                    function sartist(str) {
                        title = title + ' - ' + str;
                        document.title = title;
                    }
                }
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
                var imgTop = document.getElementById('imgSongCoverTop');
                if (response != img.src) {
                    //changeFavicon(response);
                    var link = document.querySelector("link[rel*='icon']") || document.createElement('link');
                    link.type = 'image/x-icon';
                    link.rel = 'shortcut icon';
                    link.href = response;
                    document.getElementsByTagName('head')[0].appendChild(link);
                    img.src = response;
                    imgTop.src = response;
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

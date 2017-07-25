<%@ Page Language="C#" MaintainScrollPositionOnPostback="true" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="migh.application.Default" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<!DOCTYPE html>

<html id="xd" style="background-color: #121212" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <style>
        #seekbar {
            height: 5px;
            background-color: black;
            width: 100%; 
            vertical-align: top
        }
        progress[value]::-webkit-progress-value {
            background-color: white;
        }
        label.light {
            font-family: 'Palanquin';
            vertical-align: middle;
            padding: 3px;
            font-size:12px;
            width: 100%;
            color:#FBFBFB;
        }
        label.dark {
            font-family: 'Palanquin';
            padding: 3px;
            font-size:12px;
            width: 100%;
            color:#97A09B;
        }
        ::::-webkit-scrollbar {
            width: 15px;
        }

        ::-webkit-scrollbar-track {
            background-color: #181818;
        } 
        ::-webkit-scrollbar-thumb {
            background-color: #404040;
        } 
        ::-webkit-scrollbar-button {
            background-color: black;
        } 
        ::-webkit-scrollbar-corner {
            background-color: #181818;
        } 
        #footer {
            position: fixed;
            left: 0;
            bottom: 0;
            width: 100%;
        }
        label {
            text-overflow: ellipsis;
            overflow: hidden;
            width: 30px;
            white-space: nowrap;
            vertical-align: middle;
        }
        ul.images {
            margin: auto;
            padding: 5px;
            white-space: nowrap;
            overflow-x: auto;
            background-color: #282828;
        }
        ul.images li {
            display: inline;
            width: 70px;
            height: 70px;
        }
        ol {
            background: #282828;
            padding-right: 2px;
            padding-left: 0px;
        }

        ol li {
            background: #181818;
            margin: 5px;
            border-radius:2px;
            color:#FBFBFB;
            font-family:Verdana;
            font-size:12px;
            background-clip:padding-box;
            height:40px;
            line-height:40px;
            padding-left:10px;
        }
    </style>
    <script type="text/javascript" src="js/jquery.fracs-0.15.0.js"></script>
    <link rel="shortcut icon" type="image/png" href="images/music-player.png" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<meta http-equiv="Content-Type" name="viewport" content="initial-scale=1, user-scalable=no"/>
    <title>ghost</title>
</head>
   
<body id="parentdiv" style="width: auto; background-color: #121212; background-repeat:repeat; background-attachment:fixed; background-size: 400px 400px">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
    <div id="maindiv" class="panel panel-primary" style="border-radius:3px; background-color: #282828; background-size:contain; background-position:center top; width: 100% auto; margin: 0 auto; max-width: 600px; margin-top:66px">
<%--    <div class="panel-heading" style="text-align: center; vertical-align: middle; font-family:Calibri; font-size: larger; max-width: 100%"><asp:Label ID="lblTitle" Text="migh" runat="server" /></div>--%>
        <div id="hide" style="display:none"></div>
        <table id="coverTab" style="text-align:center; width:100%">
            <tr style="width:100%">
                <%--<td style="text-align:left">
                    <asp:ImageButton ID="btnPreviousSong" runat="server" style="font-family:Calibri;" onclientclick="TriggerPreviousSong(); return false;" ImageUrl="~/images/previousSong.png"/>
                </td>--%>
                <td style="text-align: center; width:50%">
                    <img id="imgSongCover" alt="imgSongCover" style="height:250px; width:250px" src="images/default_album.png" />
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
        <asp:UpdatePanel ID="UpdatePanel2" ChildrenAsTriggers="true" UpdateMode="Conditional" runat="server">
            <ContentTemplate>
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
            </ContentTemplate>
        </asp:UpdatePanel>
        <div id="coverdiv" class="panel panel-primary" style="text-align:center; background-color: #282828; background-size:contain; background-position:center top; width: 100% auto; margin: 0 auto; max-width: 600px">
            <table id="tableImg" style="text-align: center; width:100%"">
                <tr>
                    <td>
                        <ul id="albumlist" class="images" style="background-size:contain; background-position:center top; width: 100% auto; margin: 0 auto; max-width: 600px">
                        </ul>
                    </td>
                </tr>
            </table>
        </div>
        
        <asp:UpdatePanel ID="UpdatePanel1" ChildrenAsTriggers="true" UpdateMode="Conditional" runat="server">
            <Triggers>
                
                <asp:AsyncPostBackTrigger ControlID="listAlbums" />
                <asp:AsyncPostBackTrigger ControlID="listSongs" />
            </Triggers> 
            <ContentTemplate>
                <div id="combos" class="DivTableFormat" style="width: 100%">
                    
                    <table style="text-align:center; width:100%; display:none">
                        <tr style="width:100%; height:40px">
                            <td style="width:32px; text-align:left; vertical-align:middle">
                                <img style="height:24px; width:24px" src="images/album.png" />
                            </td>
                            <td style="width:100%; height:40px">
                                <asp:DropDownList ID="listAlbums" style="color:#FBFBFB; background-color:#181818; border:none; width:100%; height:100%; font-family:Verdana" runat="server" OnSelectedIndexChanged="listAlbums_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                    <table style="text-align:center; width:100%; display:none">
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
                <div ></div>
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
    </div>
    <div id="parentTrackDiv" class="panel panel-primary" style="background-color: #282828; background-size:contain; background-position:center top; width: 100% auto; margin: 0 auto; max-width: 600px">
        <div id="tracksdiv" class="panel panel-primary" style="background-color: #282828; background-size:contain; background-position:center top; width: 100% auto; margin: 0 auto; max-width: 600px">
            <table style="width:100%;">
                <tr>
                    <td style="text-align:left">
                        <ol id="tracklist">
                        
                        </ol>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    
    <div style="height:80px; background-color:transparent"> </div>
        
    <div id="footer" style="background-color: #282828">
        <div style="opacity:0.4; height: 7px; margin-top:2px">
            <progress id="seekbar" value="0" max="1"></progress>
        </div>
        <div>
            <audio id="audio" autoplay></audio>  
        </div>
        <div style="text-align: center; height: 100%; margin-top:8px; opacity:0.7">
            <img id="previous" src="images/previous.png" style="width: 18px; height: 18px; margin-bottom: 22px; margin-right: 13px"/>
            <img id="play" src="images/play.png" style="width: 50px; height: 50px; margin-bottom:6px"/>
            <img id="next" src="images/next.png" style="width: 18px; height: 18px;; margin-bottom: 22px; margin-left: 15px"/>
            <div style="pointer-events: none; float: left; display: inline-block; position: absolute; left: 0; margin-top:-12px">
                <label id="currentTime" style="font-family: verdana; font-size: 11px; color: #FBFBFB">00:00</label>
            </div>
            <div style="pointer-events: none; float: right; display: inline-block; position: absolute; right: 0; margin-top:-12px">
                
                <label id="duration"  style="font-family: verdana; font-size: 11px; color: #FBFBFB">00:00</label>
            </div>
        </div>
    </div>
    <div style="background-color: #282828; position:fixed; top:0; left: 0; width:100%; height: 66px;">
        <table style="width:100%">
            <tr style="width:100%">
                <td id="tdImg" style="text-align: left; width:65px; vertical-align:middle">
                    <img id="imgSongCoverTop" alt="imgSongCover" style="height:61px; display:none; width:61px" src="images/default_album.png" />
                </td>
                <td id="tdTag" style="text-align:center; width:100%; vertical-align:middle; height:64px">
                    <label id="lblSongTitle" style="font-family:Verdana; font-size:12px; color:#FBFBFB">Título</label>
                    <br />
                    <label id="lblSongArtist" style="font-family:Verdana; font-size:12px; color:#97A09B">Artista</label>
                    <br />
                    <label id="lblSongAlbum" style="font-family:Verdana; font-size:12px; color:#FBFBFB">Álbum</label>
                </td>
                <td style="text-align: left; width:65px; vertical-align:middle">
                    <img id="goTop" alt="imgSongCover" style="height:32px; display:none; width:32px" src="images/uparrow.png" />
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
                var isElementInView = Utils.isElementInView($('#hide'), false);
                var off = dw_getScrollOffsets();
                if (parseInt(off.y) > 170) {
                    document.getElementById('imgSongCoverTop').style.display = 'inline';
                    //document.getElementById('goTop').style.display = 'inline';
                    document.getElementById('tdImg').style.display = 'inline';
                    var td = document.getElementById('tdTag').style.textAlign = "left";
                    td.style.textAlign = "left";
                    //$("#coverdiv").slideUp();
                } else {
                    document.getElementById('imgSongCoverTop').style.display = 'none';
                    //document.getElementById('goTop').style.display = 'none';
                    document.getElementById('tdImg').style.display = 'none';
                    var td = document.getElementById('tdTag');
                    td.style.textAlign = 'center';
                }
                if (document.body.scrollTop === 0) {
                    //$("#coverdiv").slideDown();
                    //document.getElementById('coverdiv').style.display = 'block';
                } else {
                    //$("#coverdiv").slideUp();
                    //document.getElementById('coverdiv').style.display = 'none';
                }
                //if (isElementInView) {
                //    document.getElementById('imgSongCoverTop').style.display = 'none';
                //    document.getElementById('tdImg').style.display = 'none';
                //    var td = document.getElementById('tdTag');
                //    td.style.textAlign = 'center';
                //} else {
                //    document.getElementById('imgSongCoverTop').style.display = 'inline';
                //    document.getElementById('tdImg').style.display = 'inline';
                //    var td = document.getElementById('tdTag');
                //    td.style.textAlign = 'left';
                //}
            }, true)
            //fillcovers
            window.onresize = function (event) {
                var width = document.getElementById('maindiv').offsetWidth;
                $("#albumlist").css({
                    "maxWidth": width - 15
                });
            };

            function fillCovers(srcs) {
                document.getElementById('albumlist').innerHTML = "<a />";
                var ul = document.getElementById('albumlist');
                var width = document.getElementById('maindiv').offsetWidth;
                for (i = 0; i < srcs.length; i++) {
                    var li = document.createElement('li');
                    var img = document.createElement('img');
                    var a = document.createElement('a');
                    
                    img.id = i;
                    img.src = srcs[i];
                    img.style.display = 'inline';
                    img.width = '90';
                    img.height = '90';
                    img.style.padding = '5px';
                    li.appendChild(a);
                    a.appendChild(img);
                    ul.appendChild(li);
                }
                var width = document.getElementById('maindiv').offsetWidth;
                $("#albumlist").css({
                    "maxWidth": width - 15
                });
            }
            //
            function getEventTarget(e) {
                e = e || window.event;
                return e.target || e.srcElement;
            }
            //click tracklist
            //var goTop = document.getElementById('goTop');
            //goTop.onclick = function (event) {
            //    window.scrollTo(0, 0);
            //};
            var tdTag = document.getElementById('tdTag');
            tdTag.onclick = function (event) {
                //window.scrollTo(0, 0);
                var fullscrn = document.getElementById("xd");
                req = fullscrn.requestFullScreen || fullscrn.webkitRequestFullScreen || fullscrn.mozRequestFullScreen;
                req.call(fullscrn);
            };
            var ul = document.getElementById('tracklist');
            ul.onclick = function (event) {
                var target = getEventTarget(event);
                if (target.getAttribute('type') == 'imgplay') {
                    unfade(target);
                    document.getElementById('listSongs').selectedIndex = parseInt($(target).attr('id')) + 1;
                    __doPostBack('<%= listSongs.UniqueID %>', parseInt($(target).attr('id')));
                }
            };
            //
            //get scroll dis
            function dw_getScrollOffsets() {
                var doc = document, w = window;
                var x, y, docEl;

                if (typeof w.pageYOffset === 'number') {
                    x = w.pageXOffset;
                    y = w.pageYOffset;
                } else {
                    docEl = (doc.compatMode && doc.compatMode === 'CSS1Compat') ?
                            doc.documentElement : doc.body;
                    x = docEl.scrollLeft;
                    y = docEl.scrollTop;
                }
                return { x: x, y: y };
            }

            //
            //click albumlist
            var ulartist = document.getElementById('albumlist');
            ulartist.onclick = function (event) {
                var inner = document.getElementById('tracklist').innerHTML;
                document.getElementById('parentTrackDiv').style.height = '600px';
                document.getElementById('tracklist').innerHTML = '';
                var off = dw_getScrollOffsets();
                localStorage.setItem("offSet", off.y);
                var target = getEventTarget(event);
                var id = parseInt(target.getAttribute('id'));

                document.getElementById('listAlbums').selectedIndex = id + 1;
                __doPostBack('<%= listAlbums.UniqueID %>', '');
                var offSet = localStorage.getItem("offSet");
                document.getElementById('tracklist').style.marginBottom = '80px';
                if (document.getElementById('tracklist').innerHTML == '') {
                    document.getElementById('tracklist').innerHTML = inner;
                }
                //window.scrollTo(0, offSet);
            };
            var prm = Sys.WebForms.PageRequestManager.getInstance();
            prm.add_endRequest(function (s, e) {
                var offSet = localStorage.getItem("offSet");
                //window.scrollTo(0, offSet);

            });
            //
            function playTrack(tracklist, idlist) {
                //$("#tracklist").slideUp();
                
                var ol = document.getElementById('tracklist');
                //document.getElementById('tracklist').style.display = 'none';
                document.getElementById('tracklist').innerHTML = "";
                for (i = 0; i < tracklist.length; i++) {
                    var li = document.createElement('li');
                    var img = document.createElement('img');
                    img.id = i;
                    img.setAttribute('type', 'imgplay');
                    img.src = 'images/playtrack.png';
                    img.width = 24;
                    img.height = 24;
                    img.style.marginBottom = '-8px';
                    img.style.marginRight = '10px';
                    img.style.styleFloat = 'left';
                    li.setAttribute('id', idlist[i]);
                    li.appendChild(img);
                    li.appendChild(document.createTextNode('     ' + (i+1) + '. ' + tracklist[i]));
                    li.style.overflow = 'hidden';
                    
                    ol.appendChild(li);
                }
                //$("#tracklist").slideDown();
            }
            window.onbeforeunload = function () {
                if (confirm('¿Deseas salir?'))
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
            function PlaySong() {
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
                    .then(_ => updatemetadata())
                }
            }
            function updatemetadata() {
                PageMethods.getCurrentSongTitle(title);
                var _title = '';
                var _album = '';
                var _artist = '';
                var _cover = '';
                function title(str) {
                    _title = str;
                    PageMethods.getCurrentSongAlbum(album);
                    function album(str) {
                        _album = str;
                        PageMethods.getCurrentSongArtist(artist);
                        function artist(str) {
                            _artist = str;
                            PageMethods.getCurrentSongCover(cover);
                            function cover(str) {
                                _cover = str;
                                if ('mediaSession' in navigator) {
                                    navigator.mediaSession.metadata = new MediaMetadata({
                                        title: _title,
                                        artist: _artist,
                                        album: _album,
                                        artwork: [{ src: _cover }], 
                                    });
                                    navigator.mediaSession.setActionHandler('play', function () { 
                                        document.getElementById('audio').play();
                                    });
                                    navigator.mediaSession.setActionHandler('pause', function () { 
                                        document.getElementById('audio').pause();
                                    });
                                    navigator.mediaSession.setActionHandler('previoustrack', function () { TriggerPreviousSong() });
                                    navigator.mediaSession.setActionHandler('nexttrack', function () { TriggerNextSong() });
                                }
                            }
                        }
                    }

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
                    img.src = response;
                    imgTop.src = response;
                    //$('body').css('background-image', 'url(' + response + ')');
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
            //newplayer
            var audio = document.getElementById('audio');
            var play = document.getElementById('play');
            $('#next').on('click', function () {
                var btn = document.getElementById('next');
                unfade(btn);
                TriggerNextSong();
            });
            $('#previous').on('click', function () {
                var btn = document.getElementById('previous');
                unfade(btn);
                TriggerPreviousSong();
            });
            $('#play').on('click', function () {
                var btn = document.getElementById('play');
                unfade(btn);
                if (audio.paused) {
                    audio.play();
                    play.setAttribute('src', 'images/pause.png');
                } else {
                    audio.pause();
                    play.setAttribute('src', 'images/play.png');
                }
                updatemetadata();
            });
            //$(window).blur(function(){
            //    document.getElementById('audio').pause();
            //});
            //$(window).focus(function(){
            //    document.getElementById('audio').play();
            //});
            $('#audio').on('timeupdate', function () {
                if (audio.paused) {
                    play.setAttribute('src', 'images/play.png');
                } else {
                    play.setAttribute('src', 'images/pause.png');
                }
                $('#seekbar').attr("value", this.currentTime / this.duration);
                var date = new Date(null);
                date.setSeconds(this.currentTime); // specify value for SECONDS here

                var currentTime = date.toISOString().substr(14, 5);
                var date2 = new Date(null);
                date2.setSeconds(this.duration); // specify value for SECONDS here
                var duration = date2.toISOString().substr(14, 5);
                document.getElementById('currentTime').innerHTML = currentTime;
                document.getElementById('duration').innerHTML = duration;
                updatemetadata();
            });
            document.getElementById('seekbar').addEventListener('click', function (e) {
                var x = e.pageX - this.offsetLeft, // or e.offsetX (less support, though)
                    y = e.pageY - this.offsetTop,  // or e.offsetY
                    clickedValue = x * this.max / this.offsetWidth,
                    isClicked = clickedValue;
                if (isClicked) {
                    var audio = document.getElementById("audio");
                    var newtime = audio.duration * clickedValue;
                    audio.currentTime = newtime;
                }
            });
    </script>
    </form>
</body>
</html>

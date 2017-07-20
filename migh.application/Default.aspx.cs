using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using migh.api;
using System.Web.Services;
using System.Net;
using JsonTools;

namespace migh.application
{
    public partial class Default : System.Web.UI.Page
    {
        static Library lib = null;
        User user = new User();

        #region load
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string download = Request.QueryString["download"];
                string nowplaying = Request.QueryString["nowplaying"];
                string session = Request.QueryString["session"];
                try
                {
                    if (session != null)
                    {
                        if (session.ToLower() == "end")
                        {
                            Session.Clear();
                        }
                    }
                    else
                    {
                        if (download != null)
                        {
                            if (download.ToLower() == "nowplaying")
                            {
                                if (Session["currentList"] != null)
                                {
                                    List<Song> list = Session["currentList"] as List<Song>;
                                    int index = (int)Session["currentSongIndex"];
                                    Song song = list.ElementAt(index);
                                    Artist artist = Artist.get(lib.artist_list, song.artist_id);
                                    Album album = Album.get(lib.album_list, song.album_id);
                                    string url = string.Format(lib.configuration.AudioFileURLFormat, artist.url_name, album.url_name, Tools.ConvertToGitHubFile(song.file_name, lib.configuration.GitHubFile_TextToReplace_List));
                                    Response.Redirect(url);
                                }
                            }
                            else
                            {
                                int SongID = Convert.ToInt32(download);
                                if (Song.id_exists(lib.song_list, SongID))
                                {
                                    Song song = lib.song_list.Single(n => n.id == SongID);
                                    Artist artist = Artist.get(lib.artist_list, song.artist_id);
                                    Album album = Album.get(lib.album_list, song.album_id);
                                    string url = string.Format(lib.configuration.AudioFileURLFormat, artist.url_name, album.url_name, Tools.ConvertToGitHubFile(song.file_name, lib.configuration.GitHubFile_TextToReplace_List));
                                    Response.Redirect(url);
                                }
                            }
                        }
                        else
                        {
                            if (nowplaying != null)
                            {
                                int SongID = Convert.ToInt32(nowplaying);
                                if (Song.id_exists(lib.song_list, SongID))
                                {
                                    Song song = lib.song_list.Single(n => n.id == SongID);
                                    List<Song> list = new List<Song>();
                                    list.Add(song);
                                    Session["currentList"] = list;
                                    Session["currentSongIndex"] = 0;
                                    Session["selectedSong"] = SongID;
                                    Page.ClientScript.RegisterStartupScript(this.GetType(), "script", "PlaySong();", true);
                                }
                            }
                        }
                    }
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "cleansomee()", true);
                }
                catch { }
            }
            Session.Timeout = 300;
            int t = Session.Timeout;
            try
            {
                if (Session["user"] == null || lib.artist_list.Count == 0)
                {
                    string su = "ftp://ftp.drivehq.com/migh.lib";
                    string u = "505darksoft";
                    string p = "poder123";

                    lib = new Library(su, u, p);

                    string username = "Dark";
                    user = lib.user_list.Single(us => us.name.ToLower() == username.ToLower());
                    Session.Add("user", user);
                    listArtists.SelectedIndex = 0;
                }
                user = Session["user"] as User;
                ListItem def = new ListItem();
                def.Text = "(Artista)";
                if(!listArtists.Items.Contains(def))
                {
                    listArtists.Items.Add(def);
                }
                foreach (int i in user.artist_list)
                {
                    Artist artist = Artist.get(lib.artist_list, i);
                    ListItem item = new ListItem();
                    item.Text = artist.name;
                    item.Value = artist.id.ToString();
                    if (!listArtists.Items.Contains(item))
                    {
                        listArtists.Items.Add(item);
                    }
                }
                
            }
            catch (Exception ex)
            {
                Response.Write("<script> alert('" + ex.Message + "')</script>");
            }
        }
        #endregion

        #region canción actual
        [WebMethod]
        public static string setCurrentSong()
        {
            string res = "";
            if (HttpContext.Current.Session["currentList"] != null)
            {
                List<Song> songs = HttpContext.Current.Session["currentList"] as List<Song>;
                if (HttpContext.Current.Session["currentSongIndex"] != null)
                {
                    int index = Convert.ToInt32(HttpContext.Current.Session["currentSongIndex"]);
                    Song song = songs.ElementAt(index);
                    Artist artist = Artist.get(lib.artist_list, song.artist_id);
                    Album album = Album.get(lib.album_list, song.album_id);
                    res = string.Format(lib.configuration.AudioFileURLFormat, artist.url_name, album.url_name, Tools.ConvertToGitHubFile(song.file_name, lib.configuration.GitHubFile_TextToReplace_List));
                }
            }
            return res;
        }
        #endregion

        #region url canción seleccionada
        [WebMethod]
        public static string getSongURL()
        {
            string url = "";
            if (HttpContext.Current.Session["selectedSong"] != null)
            {
                int id = Convert.ToInt32(HttpContext.Current.Session["selectedSong"]);

                foreach (Song song in lib.song_list)
                {
                    if (song.id == id)
                    {
                        Album album = Album.get(lib.album_list, song.album_id);
                        Artist artist = Artist.get(lib.artist_list, song.artist_id);
                        url = string.Format(lib.configuration.AudioFileURLFormat, artist.url_name, album.url_name, Tools.ConvertToGitHubFile(song.file_name, lib.configuration.GitHubFile_TextToReplace_List));
                        return url;
                    }
                }
            }
            return url;
        }
        #endregion

        #region información de canción actual
        [WebMethod]
        public static string getCurrentSongCover()
        {
            string res = "";
            if (HttpContext.Current.Session["currentList"] != null)
            {
                List<Song> songs = HttpContext.Current.Session["currentList"] as List<Song>;
                if (HttpContext.Current.Session["currentSongIndex"] != null)
                {
                    int index = Convert.ToInt32(HttpContext.Current.Session["currentSongIndex"]);
                    Song song = songs.ElementAt(index);
                    Artist artist = Artist.get(lib.artist_list, song.artist_id);
                    Album album = Album.get(lib.album_list, song.album_id);
                    res = string.Format(lib.configuration.AlbumCoverImageFileURLFormat, artist.url_name, album.url_name);
                }
            }
            return res;
        }
        
        [WebMethod]
        public static string getCurrentSongTitle()
        {
            string res = "";
            if (HttpContext.Current.Session["currentList"] != null)
            {
                List<Song> songs = HttpContext.Current.Session["currentList"] as List<Song>;
                if (HttpContext.Current.Session["currentSongIndex"] != null)
                {
                    int index = Convert.ToInt32(HttpContext.Current.Session["currentSongIndex"]);
                    Song song = songs.ElementAt(index);
                    res = song.name;
                }
            }
            return res;
        }
        
        [WebMethod]
        public static string getCurrentSongArtist()
        {
            string res = "";
            if (HttpContext.Current.Session["currentList"] != null)
            {
                List<Song> songs = HttpContext.Current.Session["currentList"] as List<Song>;
                if (HttpContext.Current.Session["currentSongIndex"] != null)
                {
                    int index = Convert.ToInt32(HttpContext.Current.Session["currentSongIndex"]);
                    Song song = songs.ElementAt(index);
                    Artist artist = Artist.get(lib.artist_list, song.artist_id);
                    res = artist.name;
                }
            }
            return res;
        }
        [WebMethod]
        public static string getCurrentSongAlbum()
        {
            string res = "";
            if (HttpContext.Current.Session["currentList"] != null)
            {
                List<Song> songs = HttpContext.Current.Session["currentList"] as List<Song>;
                if (HttpContext.Current.Session["currentSongIndex"] != null)
                {
                    int index = Convert.ToInt32(HttpContext.Current.Session["currentSongIndex"]);
                    Song song = songs.ElementAt(index);
                    Album album = Album.get(lib.album_list, song.album_id);
                    res = album.name;
                }
            }
            return res;
        }
        #endregion

        #region set timeout
        [WebMethod]
        public static void resetTimeout()
        {
            HttpContext.Current.Session.Timeout = 300;
        }
        #endregion

        #region canción siguiente
        [WebMethod]
        public static string getNextSong()
        {
            HttpContext.Current.Session.Timeout = 300;
            string url = "";
            if(HttpContext.Current.Session["currentList"] != null)
            {
                List<Song> songs = HttpContext.Current.Session["currentList"] as List<Song>;
                if(HttpContext.Current.Session["currentSongIndex"] != null)
                {
                    int index = Convert.ToInt32(HttpContext.Current.Session["currentSongIndex"]);
                    if(index < songs.Count-1)
                    {
                        HttpContext.Current.Session["currentSongIndex"] = index + 1;
                        Song nextSong = songs.ElementAt(index + 1);
                        Artist artist = Artist.get(lib.artist_list, nextSong.artist_id);
                        Album album = Album.get(lib.album_list, nextSong.album_id);
                        url = string.Format(lib.configuration.AudioFileURLFormat, artist.url_name, album.url_name, Tools.ConvertToGitHubFile(nextSong.file_name, lib.configuration.GitHubFile_TextToReplace_List));
                        return url;
                    }
                }
            }
            return url;
        }
        #endregion

        #region canción anterior
        [WebMethod]
        public static string getPreviousSong()
        {
            string url = "";
            if (HttpContext.Current.Session["currentList"] != null)
            {
                List<Song> songs = HttpContext.Current.Session["currentList"] as List<Song>;
                if (HttpContext.Current.Session["currentSongIndex"] != null)
                {
                    int index = Convert.ToInt32(HttpContext.Current.Session["currentSongIndex"]);
                    if (index > 0)
                    {
                        HttpContext.Current.Session["currentSongIndex"] = index - 1;
                        Song previousSong = songs.ElementAt(index - 1);
                        Artist artist = Artist.get(lib.artist_list, previousSong.artist_id);
                        Album album = Album.get(lib.album_list, previousSong.album_id);
                        url = string.Format(lib.configuration.AudioFileURLFormat, artist.url_name, album.url_name, Tools.ConvertToGitHubFile(previousSong.file_name, lib.configuration.GitHubFile_TextToReplace_List));
                        return url;
                    }
                }
            }
            return url;
        }
        #endregion

        #region eventos combos
        protected void listArtists_SelectedIndexChanged(object sender, EventArgs e)
        {
            List<ListItem> list = new List<ListItem>();
            if(listArtists.SelectedIndex > 0)
            {
                listAlbums.Items.Clear();
                listAlbums.Items.Add("(Álbum)");
                listSongs.Items.Clear();
                listSongs.Items.Add("(Canción)");
                Artist artist = Artist.get(lib.artist_list, Convert.ToInt32(listArtists.SelectedValue));
                if(artist != null)
                {
                    List<string> albumimg = new List<string>();
                    foreach(Album album in lib.album_list)
                    {
                        if(album.artist_id == artist.id)
                        {
                            albumimg.Add(string.Format(lib.configuration.AlbumCoverImageFileURLFormat, artist.url_name, album.url_name));
                            ListItem item = new ListItem();
                            item.Text = album.name;
                            item.Value = album.id.ToString();
                            listAlbums.Items.Add(item);
                            foreach(Song song in lib.song_list)
                            {
                                if(song.artist_id == artist.id)
                                {
                                    ListItem itemSong = new ListItem();
                                    itemSong.Text = song.name;
                                    itemSong.Value = song.id.ToString();
                                    if(!listSongs.Items.Contains(itemSong))
                                    {
                                        listSongs.Items.Add(itemSong);
                                    }
                                }
                            }
                        }
                    }
                    listAlbums.SelectedIndex = 0;
                    listSongs.SelectedIndex = 0;
                    var acovers = Newtonsoft.Json.JsonConvert.SerializeObject(albumimg.ToArray<string>());
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "fillCovers(" + acovers + ")", true);
                }
            }
            else
            {
                listAlbums.Items.Clear();
                listAlbums.Items.Add("(Álbum)");
                listSongs.Items.Clear();
                listSongs.Items.Add("(Canción)");
                foreach(Album album in lib.album_list)
                {
                    ListItem item = new ListItem();
                    item.Text = album.name;
                    item.Value = album.id.ToString();
                    listAlbums.Items.Add(item);
                }
                foreach (Song song in lib.song_list)
                {
                    ListItem item = new ListItem();
                    item.Text = song.name;
                    item.Value = song.id.ToString();
                    listSongs.Items.Add(item);
                }
            }
            UpdatePanel1.Update();
        }

        protected void listAlbums_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (listAlbums.SelectedIndex > 0)
            {
                listSongs.Items.Clear();
                listSongs.Items.Add("(Canción)");
                Album album = Album.get(lib.album_list, Convert.ToInt32(listAlbums.SelectedValue));
                List<string> tracks = new List<string>();
                List<int> ids = new List<int>();
                int tracki = 1;
                if (album != null)
                {
                    foreach (Song song in lib.song_list)
                    {
                        if (song.album_id == album.id)
                        {
                            ListItem item = new ListItem();
                            item.Text = song.name;
                            item.Value = song.id.ToString();
                            tracks.Add(song.name);
                            ids.Add(song.id);
                            if(!listSongs.Items.Contains(item))
                            {
                                listSongs.Items.Add(item);
                            }
                            tracki++;
                        }
                    }
                    listSongs.SelectedIndex = 0;
                    var tracklist = Newtonsoft.Json.JsonConvert.SerializeObject(tracks.ToArray<string>());
                    var idlist = Newtonsoft.Json.JsonConvert.SerializeObject(ids.ToArray<int>());
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "playTrack(" + tracklist + "," + idlist +")", true);
                }
            }
            else
            {
                try
                {
                    Album album = Album.get(lib.album_list, Convert.ToInt32(listAlbums.SelectedValue));
                    Artist artist = Artist.get(lib.artist_list, album.artist_id);
                    listSongs.Items.Clear();
                    listSongs.Items.Add("(Canción)");
                    foreach (Song song in lib.song_list)
                    {
                        if (song.artist_id == artist.id)
                        {
                            ListItem item = new ListItem();
                            item.Text = song.name;
                            item.Value = song.id.ToString();
                            listSongs.Items.Add(item);
                        }
                    }
                }
                catch { }
                
            }
        }

        protected void listSongs_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (listSongs.SelectedIndex > 0)
            {
                List<Song> songs = new List<Song>();
                int index = listSongs.SelectedIndex -1;
                for (int i = 1; i < listSongs.Items.Count; i++)
                {
                    ListItem item = listSongs.Items[i] as ListItem;
                    foreach (Song song in lib.song_list)
                    {
                        if (song.id == Convert.ToInt32(item.Value))
                        {
                            songs.Add(song);
                            break;
                        }
                    }
                }
                Session.Add("currentList", songs);
                Session.Add("currentSongIndex", index);
                Session.Add("selectedSong", Convert.ToInt32(listSongs.SelectedValue));
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "PlaySong()", true);
            }
        }
        #endregion
    }
}
// ===========================================================================
// Purpose:     wxFile, wxDir, wxFileName and file functions
// Author:      J Winwood, John Labenski
// Created:     14/11/2001
// Copyright:   (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence:     wxWidgets licence
// wxWidgets:   Updated to 2.8.4
// ===========================================================================

#include "wx/filefn.h"
#include "sys/stat.h"

enum wxSeekMode
{
  wxFromStart,
  wxFromCurrent,
  wxFromEnd
};

enum wxFileKind
{
  wxFILE_KIND_UNKNOWN,
  wxFILE_KIND_DISK,     // a file supporting seeking to arbitrary offsets
  wxFILE_KIND_TERMINAL, // a tty
  wxFILE_KIND_PIPE      // a pipe
};

// we redefine these constants here because S_IREAD &c are _not_ standard
// however, we do assume that the values correspond to the Unix umask bits
enum wxPosixPermissions
{
    // standard Posix names for these permission flags:
    wxS_IRUSR,
    wxS_IWUSR,
    wxS_IXUSR,

    wxS_IRGRP,
    wxS_IWGRP,
    wxS_IXGRP,

    wxS_IROTH,
    wxS_IWOTH,
    wxS_IXOTH,

    // longer but more readable synonyms for the constants above:
    wxPOSIX_USER_READ,
    wxPOSIX_USER_WRITE,
    wxPOSIX_USER_EXECUTE,

    wxPOSIX_GROUP_READ,
    wxPOSIX_GROUP_WRITE,
    wxPOSIX_GROUP_EXECUTE,

    wxPOSIX_OTHERS_READ,
    wxPOSIX_OTHERS_WRITE,
    wxPOSIX_OTHERS_EXECUTE,

    // default mode for the new files: allow reading/writing them to everybody but
    // the effective file mode will be set after anding this value with umask and
    // so won't include wxS_IW{GRP,OTH} for the default 022 umask value
    wxS_DEFAULT,

    // default mode for the new directories (see wxFileName::Mkdir): allow
    // reading/writing/executing them to everybody, but just like wxS_DEFAULT
    // the effective directory mode will be set after anding this value with umask
    wxS_DIR_DEFAULT
};

// ----------------------------------------------------------------------------
// functions
// ----------------------------------------------------------------------------

bool wxFileExists(const wxString& filename);

// does the path exist? (may have or not '/' or '\\' at the end)
bool wxDirExists(const wxString& pathName);

bool wxIsAbsolutePath(const wxString& filename);

// Get filename
//wxString wxFileNameFromPath(wxString path);
wxString wxFileNameFromPath(const wxString& path);

// Get directory
wxString wxPathOnly(const wxString& path);

// Get first file name matching given wild card.
// Flags are reserved for future use.
#define wxFILE
#define wxDIR
wxString wxFindFirstFile(const wxString& spec, int flags = wxFILE);
wxString wxFindNextFile();

// Does the pattern contain wildcards?
bool wxIsWild(const wxString& pattern);

// Does the pattern match the text (usually a filename)?
// If dot_special is true, doesn't match * against . (eliminating
// `hidden' dot files)
bool wxMatchWild(const wxString& pattern, const wxString& text, bool dot_special = true);

// Concatenate two files to form third
bool wxConcatFiles(const wxString& src1, const wxString& src2, const wxString& dest);

// Copy file
bool wxCopyFile(const wxString& src, const wxString& dest, bool overwrite = true);

// Remove file
bool wxRemoveFile(const wxString& file);

// Rename file
bool wxRenameFile(const wxString& oldpath, const wxString& newpath, bool overwrite = true);

// Get current working directory.
wxString wxGetCwd();

// Set working directory
bool wxSetWorkingDirectory(const wxString& d);

// Make directory
bool wxMkdir(const wxString& dir, int perm = wxS_DIR_DEFAULT);

// Remove directory. Flags reserved for future use.
bool wxRmdir(const wxString& dir, int flags = 0);

// Return the type of an open file
wxFileKind wxGetFileKind(int fd);
//wxFileKind wxGetFileKind(FILE *fp);

// permissions; these functions work both on files and directories:
bool wxIsWritable(const wxString &path);
bool wxIsReadable(const wxString &path);
bool wxIsExecutable(const wxString &path);

// ----------------------------------------------------------------------------
// separators in file names
// ----------------------------------------------------------------------------

// wxLua only has storage for wxChar* in bindings, wxFILE_SEP_XXX are #defined
//   as wxChar wxT('.'), so we just redefine them to be wxT(".") or wxChar*

// between file name and extension
#define_wxstring wxFILE_SEP_EXT       wxT(".");

// between drive/volume name and the path
#define_wxstring wxFILE_SEP_DSK       wxT(":");

// between the path components
#define_wxstring wxFILE_SEP_PATH_DOS  wxT("\\");
#define_wxstring wxFILE_SEP_PATH_UNIX wxT("/");
#define_wxstring wxFILE_SEP_PATH_MAC  wxT(":");
#define_wxstring wxFILE_SEP_PATH_VMS  wxT("."); // VMS also uses '[' and ']'

// separator in the path list (as in PATH environment variable)
// there is no PATH variable in Classic Mac OS so just use the
// semicolon (it must be different from the file name separator)
// NB: these are strings and not characters on purpose!
#define_wxstring wxPATH_SEP_DOS       wxT(";");
#define_wxstring wxPATH_SEP_UNIX      wxT(":");
#define_wxstring wxPATH_SEP_MAC       wxT(";");

#define_wxstring wxFILE_SEP_PATH wxLua_FILE_SEP_PATH // hack to convert from wxChar wxT('') to wxChar* wxT("");
#define_wxstring wxPATH_SEP           wxPATH_SEP_DOS

// this is useful for wxString::IsSameAs(): to compare two file names use
// filename1.IsSameAs(filename2, wxARE_FILENAMES_CASE_SENSITIVE)
#define wxARE_FILENAMES_CASE_SENSITIVE // bool 1/0

// is the char a path separator?
bool wxIsPathSeparator(wxChar ch);

// does the string ends with path separator?
bool wxEndsWithPathSeparator(const wxString& filename);

// find a file in a list of directories, returns false if not found
bool wxFindFileInPath(wxString *pStr, const wxString& szPath, const wxString& szFile);

// Get the OS directory if appropriate (such as the Windows directory).
// On non-Windows platform, probably just return the empty string.
wxString wxGetOSDirectory();

#if wxUSE_DATETIME

// %override wxDateTime wxFileModificationTime(const wxString& filename) (not overridden, just return wxDateTime);
// C++ Func: time_t wxFileModificationTime(const wxString& filename);
// Get file modification time
wxDateTime wxFileModificationTime(const wxString& filename);

#endif // wxUSE_DATETIME

// Parses the wildCard, returning the number of filters.
// Returns 0 if none or if there's a problem,
// The arrays will contain an equal number of items found before the error.
// wildCard is in the form:
// "All files (*)|*|Image Files (*.jpeg *.png)|*.jpg;*.png"
//int wxParseCommonDialogsFilter(const wxString& wildCard, wxArrayString& descriptions, wxArrayString& filters);

// These methods are for wxLua
// %override long wxFileSize(const wxString& fileName) - gets the filesize
long wxFileSize(const wxString& fileName);

#include "wx/utils.h"

// get number of total/free bytes on the disk where path belongs
bool wxGetDiskSpace(const wxString& path, wxLongLong *pTotal = NULL, wxLongLong *pFree = NULL);

// ---------------------------------------------------------------------------
// wxPathList

class %delete wxPathList : public wxArrayString
{
    wxPathList();
    //wxPathList(const wxArrayString &arr);

    // Adds all paths in environment variable
    void AddEnvList(const wxString& envVariable);

    // Adds given path to this list
    bool Add(const wxString& path);
    void Add(const wxArrayString &paths);

    // Find the first full path for which the file exists
    wxString FindValidPath(const wxString& filename) const;

    // Find the first full path for which the file exists; ensure it's an
    // absolute path that gets returned.
    wxString FindAbsoluteValidPath(const wxString& filename) const;

    // Given full path and filename, add path to list
    bool EnsureFileAccessible(const wxString& path);

};

// ---------------------------------------------------------------------------
// wxStandardPaths

#if wxLUA_USE_wxStandardPaths

#include "wx/stdpaths.h"

// possible resources categories
enum wxStandardPaths::ResourceCat
{
    ResourceCat_None,     // no special category
    ResourceCat_Messages, // message catalog resources
    ResourceCat_Max       // end of enum marker
};

enum wxStandardPaths::Dir
{
    Dir_Cache,

    /**
        Directory containing user documents.

        Example return values:
        - Unix/Mac: @c ~/Documents
        - Windows: @c "C:\Users\username\Documents"
    */
    Dir_Documents,

    /**
        Directory containing files on the users desktop.

        Example return values:
        - Unix/Mac: @c ~/Desktop
        - Windows: @c "C:\Users\username\Desktop"
    */
    Dir_Desktop,

    /**
        Directory for downloaded files

        Example return values:
        - Unix/Mac: @c ~/Downloads
        - Windows: @c "C:\Users\username\Downloads" (Only available on Vista and newer)
    */
    Dir_Downloads,

    /**
        Directory containing music files.

        Example return values:
        - Unix/Mac: @c ~/Music
        - Windows: @c "C:\Users\username\Music"
    */
    Dir_Music,

    /**
        Directory containing picture files.

        Example return values:
        - Unix/Mac: @c ~/Pictures
        - Windows: @c "C:\Users\username\Pictures"
    */
    Dir_Pictures,

    /**
        Directory containing video files.

        Example return values:
        - Unix: @c ~/Videos
        - Windows: @c "C:\Users\username\Videos"
        - Mac: @c ~/Movies
    */
    Dir_Videos
};

class wxStandardPaths // ignore wxStandardPathsBase
{
    // return the global standard paths object
    static wxStandardPaths& Get();
    
    // return the path (directory+filename) of the running executable or
    // wxEmptyString if it couldn't be determined.
    // The path is returned as an absolute path whenever possible.
    // Default implementation only try to use wxApp->argv[0].
    virtual wxString GetExecutablePath() const;

    // return the directory with system config files:
    // /etc under Unix, c:\Documents and Settings\All Users\Application Data
    // under Windows, /Library/Preferences for Mac
    virtual wxString GetConfigDir() const;

    // return the directory for the user config files:
    // $HOME under Unix, c:\Documents and Settings\username under Windows,
    // ~/Library/Preferences under Mac
    //
    // only use this if you have a single file to put there, otherwise
    // GetUserDataDir() is more appropriate
    virtual wxString GetUserConfigDir() const = 0;

    // return the location of the applications global, i.e. not user-specific,
    // data files
    //
    // prefix/share/appname under Unix, c:\Program Files\appname under Windows,
    // appname.app/Contents/SharedSupport app bundle directory under Mac
    virtual wxString GetDataDir() const;

    // return the location for application data files which are host-specific
    //
    // same as GetDataDir() except under Unix where it is /etc/appname
    virtual wxString GetLocalDataDir() const;

    // return the directory for the user-dependent application data files
    //
    // $HOME/.appname under Unix,
    // c:\Documents and Settings\username\Application Data\appname under Windows
    // and ~/Library/Application Support/appname under Mac
    virtual wxString GetUserDataDir() const;

    // return the directory for user data files which shouldn't be shared with
    // the other machines
    //
    // same as GetUserDataDir() for all platforms except Windows where it is
    // the "Local Settings\Application Data\appname" directory
    virtual wxString GetUserLocalDataDir() const;

    // return the directory where the loadable modules (plugins) live
    //
    // prefix/lib/appname under Unix, program directory under Windows and
    // Contents/Plugins app bundle subdirectory under Mac
    virtual wxString GetPluginsDir() const;

    // get resources directory: resources are auxiliary files used by the
    // application and include things like image and sound files
    //
    // same as GetDataDir() for all platforms except Mac where it returns
    // Contents/Resources subdirectory of the app bundle
    virtual wxString GetResourcesDir() const;

    // get localized resources directory containing the resource files of the
    // specified category for the given language
    //
    // in general this is just GetResourcesDir()/lang under Windows and Unix
    // and GetResourcesDir()/lang.lproj under Mac but is something quite
    // different under Unix for message catalog category (namely the standard
    // prefix/share/locale/lang/LC_MESSAGES)
    virtual wxString GetLocalizedResourcesDir(const wxString& lang, wxStandardPaths::ResourceCat category = wxStandardPaths::ResourceCat_None) const; // %override parameter types

    // return the "Documents" directory for the current user
    //
    // C:\Documents and Settings\username\My Documents under Windows,
    // $HOME under Unix and ~/Documents under Mac
    virtual wxString GetDocumentsDir() const;

    // return the directory for the documents files used by this application:
    // it's a subdirectory of GetDocumentsDir() constructed using the
    // application name/vendor if it exists or just GetDocumentsDir() otherwise
    virtual wxString GetAppDocumentsDir() const;

    // return the temporary directory for the current user
    virtual wxString GetTempDir() const;

    virtual wxString GetUserDir(wxStandardPaths::Dir userDir) const; // %override parameter type
    
    //virtual wxString MakeConfigFileName(const wxString& basename, ConfigFileConv conv = ConfigFileConv_Ext) const;

    // Information used by AppendAppInfo
    void UseAppInfo(int info)
    //bool UsesAppInfo(int info) const;

    //void SetFileLayout(FileLayout layout);
    //FileLayout GetFileLayout() const;

    %win void IgnoreAppSubDir(const wxString& subdirPattern);
    %win void IgnoreAppBuildSubDirs();
    %win void DontIgnoreAppSubDir();
    // Returns the directory corresponding to the specified Windows shell CSIDL
    %win static wxString MSWGetShellDir(int csidl);

    // tries to determine the installation prefix automatically (Linux only right
    // now) and returns /usr/local if it failed
    %gtk void DetectPrefix();
    %gtk wxString GetInstallPrefix() const;
    %gtk void SetInstallPrefix(const wxString& prefix);
    
};

#endif // wxLUA_USE_wxStandardPaths

// ---------------------------------------------------------------------------
// wxFileName

#if wxLUA_USE_wxFileName

#include "wx/filename.h"

// the various values for the path format: this mainly affects the path
// separator but also whether or not the path has the drive part (as under
// Windows)
enum wxPathFormat
{
    wxPATH_NATIVE,      // the path format for the current platform
    wxPATH_UNIX,
    wxPATH_BEOS,
    wxPATH_MAC,
    wxPATH_DOS,
    wxPATH_WIN,
    wxPATH_OS2,
    wxPATH_VMS,

    wxPATH_MAX // Not a valid value for specifying path format
};

// different conventions that may be used with GetHumanReadableSize()
enum wxSizeConvention
{
    wxSIZE_CONV_TRADITIONAL,  // 1024 bytes = 1 KB
    wxSIZE_CONV_IEC,          // 1024 bytes = 1 KiB
    wxSIZE_CONV_SI            // 1000 bytes = 1 KB
};

// the kind of normalization to do with the file name: these values can be
// or'd together to perform several operations at once
enum wxPathNormalize
{
    wxPATH_NORM_ENV_VARS,  // replace env vars with their values
    wxPATH_NORM_DOTS,      // squeeze all .. and .
    wxPATH_NORM_TILDE,     // Unix only: replace ~ and ~user
    wxPATH_NORM_CASE,      // if case insensitive => tolower
    wxPATH_NORM_ABSOLUTE,  // make the path absolute
    wxPATH_NORM_LONG,      // make the path the long form
    wxPATH_NORM_SHORTCUT,  // resolve the shortcut, if it is a shortcut
    wxPATH_NORM_ALL
};

// what exactly should GetPath() return?
enum
{
    wxPATH_NO_SEPARATOR,  // for symmetry with wxPATH_GET_SEPARATOR
    wxPATH_GET_VOLUME,    // include the volume if applicable
    wxPATH_GET_SEPARATOR  // terminate the path with the separator
};

// Mkdir flags
enum
{
    wxPATH_MKDIR_FULL   // create directories recursively
};

// Rmdir flags
enum
{
    wxPATH_RMDIR_FULL,      // delete with subdirectories if empty
    wxPATH_RMDIR_RECURSIVE  // delete all recursively (dangerous!)
};

// FileExists flags
enum
{
    wxFILE_EXISTS_REGULAR,    // check for existence of a regular file
    wxFILE_EXISTS_DIR,        // check for existence of a directory
    wxFILE_EXISTS_SYMLINK,    // check for existence of a symbolic link;
                              // also sets wxFILE_EXISTS_NO_FOLLOW as
                              // it would never be satisfied otherwise
    wxFILE_EXISTS_DEVICE,     // check for existence of a device
    wxFILE_EXISTS_FIFO,       // check for existence of a FIFO
    wxFILE_EXISTS_SOCKET,     // check for existence of a socket
                                       // gap for future types
    wxFILE_EXISTS_NO_FOLLOW,  // don't dereference a contained symlink
    wxFILE_EXISTS_ANY         // check for existence of anything
};

class %delete wxFileName
{
    wxFileName();
    wxFileName(const wxFileName& filepath);
    wxFileName(const wxString& fullpath, wxPathFormat format = wxPATH_NATIVE);
    wxFileName(const wxString& path, const wxString& name, wxPathFormat format = wxPATH_NATIVE);
    wxFileName(const wxString& volume, const wxString& path, const wxString& name, const wxString& ext, wxPathFormat format = wxPATH_NATIVE);
    wxFileName(const wxString& path, const wxString& name, const wxString& ext, wxPathFormat format = wxPATH_NATIVE);
    
    void Assign(const wxFileName& filepath);
    void Assign(const wxString& fullpath, wxPathFormat format = wxPATH_NATIVE);
    void Assign(const wxString& volume, const wxString& path, const wxString& name, const wxString& ext, bool hasExt, wxPathFormat format = wxPATH_NATIVE);
    void Assign(const wxString& volume, const wxString& path, const wxString& name, const wxString& ext, wxPathFormat format = wxPATH_NATIVE);
    void Assign(const wxString& path, const wxString& name, wxPathFormat format = wxPATH_NATIVE);
    void Assign(const wxString& path, const wxString& name, const wxString& ext, wxPathFormat format = wxPATH_NATIVE);
    
    void AssignDir(const wxString& dir, wxPathFormat format = wxPATH_NATIVE);
    
    // reset all components to default, uninitialized state
    void Clear();
    
    static wxFileName FileName(const wxString& file, wxPathFormat format = wxPATH_NATIVE);
    static wxFileName DirName(const wxString& dir, wxPathFormat format = wxPATH_NATIVE);
    
    // is the filename valid at all?
    bool IsOk() const;
    
    // does the file with this name exist?
    bool FileExists() const;
    static bool FileExists(const wxString &file);
    
    // does the directory with this name exist?
    bool DirExists() const;
    static bool DirExists(const wxString &dir);
    
    // does anything at all with this name (i.e. file, directory or some
    // other file system object such as a device, socket, ...) exist?
    bool Exists(int flags = wxFILE_EXISTS_ANY) const;
    static bool Exists(const wxString& path, int flags = wxFILE_EXISTS_ANY);
    
    // checks on most common flags for files/directories;
    // more platform-specific features (like e.g. Unix permissions) are not
    // available in wxFileName

    bool IsDirWritable() const;
    static bool IsDirWritable(const wxString &path);

    bool IsDirReadable() const;
    static bool IsDirReadable(const wxString &path);

    // NOTE: IsDirExecutable() is not present because the meaning of "executable"
    //       directory is very platform-dependent and also not so useful

    bool IsFileWritable() const;
    static bool IsFileWritable(const wxString &path);

    bool IsFileReadable() const;
    static bool IsFileReadable(const wxString &path);

    bool IsFileExecutable() const;
    static bool IsFileExecutable(const wxString &path);

    // set the file permissions to a combination of wxPosixPermissions enum
    // values
    bool SetPermissions(int permissions);
    
    // time functions
#if wxUSE_DATETIME
    // set the file last access/mod and creation times
    // (any of the pointers may be NULL)
    bool SetTimes(const wxDateTime *dtAccess, const wxDateTime *dtMod, const wxDateTime *dtCreate) const;

    // set the access and modification times to the current moment
    bool Touch() const;

    // %override [bool, wxDateTime dtAccess, wxDateTime dtMod, wxDateTime dtCreate] wxFileName::GetTimes();
    // C++ Func: bool GetTimes(wxDateTime *dtAccess, wxDateTime *dtMod, wxDateTime *dtCreate) const;
    // return the last access, last modification and create times
    // (any of the pointers may be NULL)
    bool GetTimes() const;

    // convenience wrapper: get just the last mod time of the file
    wxDateTime GetModificationTime() const;
#endif // wxUSE_DATETIME
    
    
    // various file/dir operations

    // retrieve the value of the current working directory
    void AssignCwd(const wxString& volume = wxEmptyString);
    static wxString GetCwd(const wxString& volume = wxEmptyString);

    // change the current working directory
    bool SetCwd() const;
    static bool SetCwd( const wxString &cwd );

    // get the value of user home (Unix only mainly)
    void AssignHomeDir();
    static wxString GetHomeDir();

    // get the system temporary directory
    static wxString GetTempDir();

    wxUSE_FILE void AssignTempFileName(const wxString& prefix);
    wxUSE_FILE static wxString CreateTempFileName(const wxString& prefix);
    
    wxUSE_FILE void AssignTempFileName(const wxString& prefix, wxFile *fileTemp);
    wxUSE_FILE static wxString CreateTempFileName(const wxString& prefix, wxFile *fileTemp);
    
    //void AssignTempFileName(const wxString& prefix, wxFFile *fileTemp);  // wxFFile no available in wxlua
    //static wxString CreateTempFileName(const wxString& prefix, wxFFile *fileTemp);  // wxFFile no available in wxlua
    
    // directory creation and removal.
    bool Mkdir(int perm = wxS_DIR_DEFAULT, int flags = 0) const;
    static bool Mkdir(const wxString &dir, int perm = wxS_DIR_DEFAULT, int flags = 0);

    bool Rmdir(int flags = 0) const;
    static bool Rmdir(const wxString &dir, int flags = 0);

    // operations on the path

    // normalize the path: with the default flags value, the path will be
    // made absolute, without any ".." and "." and all environment
    // variables will be expanded in it
    //
    // this may be done using another (than current) value of cwd
    bool Normalize(int flags = wxPATH_NORM_ALL, const wxString& cwd = wxEmptyString, wxPathFormat format = wxPATH_NATIVE);

    // get a path path relative to the given base directory, i.e. opposite
    // of Normalize
    //
    // pass an empty string to get a path relative to the working directory
    //
    // returns true if the file name was modified, false if we failed to do
    // anything with it (happens when the file is on a different volume,
    // for example)
    bool MakeRelativeTo(const wxString& pathBase = wxEmptyString, wxPathFormat format = wxPATH_NATIVE);

    // make the path absolute
    //
    // this may be done using another (than current) value of cwd
    bool MakeAbsolute(const wxString& cwd = wxEmptyString, wxPathFormat format = wxPATH_NATIVE);
        
    // If the path is a symbolic link (Unix-only), indicate that all
    // filesystem operations on this path should be performed on the link
    // itself and not on the file it points to, as is the case by default.
    //
    // No effect if this is not a symbolic link.
    void DontFollowLink();

    // If the path is a symbolic link (Unix-only), returns whether various
    // file operations should act on the link itself, or on its target.
    //
    // This does not test if the path is really a symlink or not.
    bool ShouldFollowLink() const;
    
//#if defined(__WIN32__) && wxUSE_OLE
    // if the path is a shortcut, return the target and optionally,
    // the arguments
//    bool GetShortcutTarget(const wxString& shortcutPath, wxString& targetFilename, wxString* arguments = NULL) const;
//#endif

    // if the path contains the value of the environment variable named envname
    // then this function replaces it with the string obtained from
    //    wxString::Format(replacementFmtString, value_of_envname_variable)
    //
    // Example:
    //    wxFileName fn("/usr/openwin/lib/someFile");
    //    fn.ReplaceEnvVariable("OPENWINHOME");
    //         // now fn.GetFullPath() == "$OPENWINHOME/lib/someFile"
    bool ReplaceEnvVariable(const wxString& envname, const wxString& replacementFmtString = "$%s", wxPathFormat format = wxPATH_NATIVE);

    // replaces, if present in the path, the home directory for the given user
    // (see wxGetHomeDir) with a tilde
    bool ReplaceHomeDir(wxPathFormat format = wxPATH_NATIVE);

    // Comparison

    // compares with the rules of the given platforms format
    bool SameAs(const wxFileName& filepath, wxPathFormat format = wxPATH_NATIVE) const;
    
    // are the file names of this type cases sensitive?
    static bool IsCaseSensitive(wxPathFormat format = wxPATH_NATIVE);

    // is this filename absolute?
    bool IsAbsolute(wxPathFormat format = wxPATH_NATIVE) const;

    // is this filename relative?
    bool IsRelative(wxPathFormat format = wxPATH_NATIVE) const;

    // Returns the characters that aren't allowed in filenames
    // on the specified platform.
    static wxString GetForbiddenChars(wxPathFormat format = wxPATH_NATIVE);

    // Information about path format

    // get the string separating the volume from the path for this format,
    // return an empty string if this format doesn't support the notion of
    // volumes at all
    static wxString GetVolumeSeparator(wxPathFormat format = wxPATH_NATIVE);

    // get the string of path separators for this format
    static wxString GetPathSeparators(wxPathFormat format = wxPATH_NATIVE);

    // get the string of path terminators, i.e. characters which terminate the
    // path
    static wxString GetPathTerminators(wxPathFormat format = wxPATH_NATIVE);

    // get the canonical path separator for this format
    static int GetPathSeparator(wxPathFormat format = wxPATH_NATIVE);

    // is the char a path separator for this format?
    static bool IsPathSeparator(wxChar ch, wxPathFormat format = wxPATH_NATIVE);

    // is this is a DOS path which beings with a windows unique volume name
    // ('\\?\Volume{guid}\')?
    %win static bool IsMSWUniqueVolumeNamePath(const wxString& path, wxPathFormat format = wxPATH_NATIVE);
    
    
    // Dir accessors
    int GetDirCount() const;
    bool AppendDir(const wxString& dir);
    void PrependDir(const wxString& dir);
    bool InsertDir(int before, const wxString& dir);
    void RemoveDir(size_t pos);
    void RemoveLastDir();

    // Other accessors
    void SetExt(const wxString &ext);
    void ClearExt();
    void SetEmptyExt();
    wxString GetExt() const;
    bool HasExt() const;

    void SetName(const wxString &name);
    wxString GetName() const;
    bool HasName() const;

    void SetVolume(const wxString &volume);
    wxString GetVolume() const;
    bool HasVolume() const;

    // full name is the file name + extension (but without the path)
    void SetFullName(const wxString& fullname);
    wxString GetFullName() const;

    const wxArrayString& GetDirs() const; // %override [Lua string table] wxFileName::GetDirs();

    // flags are combination of wxPATH_GET_XXX flags
    wxString GetPath(int flags = wxPATH_GET_VOLUME, wxPathFormat format = wxPATH_NATIVE) const;

    // Replace current path with this one
    void SetPath(const wxString &path, wxPathFormat format = wxPATH_NATIVE);

    // Construct full path with name and ext
    wxString GetFullPath(wxPathFormat format = wxPATH_NATIVE) const;

    // Return the short form of the path (returns identity on non-Windows platforms)
    wxString GetShortPath() const;

    // Return the long form of the path (returns identity on non-Windows platforms)
    wxString GetLongPath() const;

    // Is this a file or directory (not necessarily an existing one)
    bool IsDir() const;
    
    // various helpers

    // get the canonical path format for this platform
    static wxPathFormat GetFormat(wxPathFormat format = wxPATH_NATIVE);

    // split a fullpath into the volume, path, (base) name and extension
    // (all of the pointers can be NULL)
    //static void SplitPath(const wxString& fullpath, wxString *volume, wxString *path, wxString *name, wxString *ext, bool *hasExt = NULL, wxPathFormat format = wxPATH_NATIVE);
    
    // %override [wxString path, wxString path, wxString name, wxString ext] wxFileName::SplitPath(const wxString& fullpath, wxPathFormat format = wxPATH_NATIVE);
    // C++ Func: static void SplitPath(const wxString& fullpath, wxString *volume, wxString *path, wxString *name, wxString *ext, wxPathFormat format);
    %rename SplitPathVolume static void SplitPath(const wxString& fullpath, wxPathFormat format = wxPATH_NATIVE);

		// %override [wxString path, wxString name, wxString ext] wxFileName::SplitPath(const wxString& fullpath, wxPathFormat format = wxPATH_NATIVE);
    // C++ Func: static void SplitPath(const wxString& fullpath, wxString *path, wxString *name, wxString *ext, wxPathFormat format = wxPATH_NATIVE);
    // compatibility version: volume is part of path
    static void SplitPath(const wxString& fullpath, wxPathFormat format = wxPATH_NATIVE);

    // %override [wxString volume, wxString path] wxFileName::SplitVolume(const wxString& fullpath, wxPathFormat format = wxPATH_NATIVE);
    // C++ Func: static void SplitVolume(const wxString& fullpathWithVolume, wxString *volume, wxString *path, wxPathFormat format = wxPATH_NATIVE);
    // split a path into volume and pure path part
    static void SplitVolume(const wxString& fullpath, wxPathFormat format = wxPATH_NATIVE);

    // strip the file extension: "foo.bar" => "foo" (but ".baz" => ".baz")
    static wxString StripExtension(const wxString& fullpath);

//#ifdef wxHAS_FILESYSTEM_VOLUMES
    // return the string representing a file system volume, or drive
    %win static wxString GetVolumeString(char drive, int flags = wxPATH_GET_SEPARATOR); // %override as it's win-only
//#endif // wxHAS_FILESYSTEM_VOLUMES
    
    // File size

//#if wxUSE_LONGLONG
    // returns the size of the given filename
    wxULongLong GetSize() const;
    static wxULongLong GetSize(const wxString &file);

    // returns the size in a human readable form
    wxString GetHumanReadableSize(const wxString& nullsize = "Not available", int precision = 1, wxSizeConvention conv = wxSIZE_CONV_TRADITIONAL) const; // %override to remote _() as it's not handled by wxlua
    static wxString GetHumanReadableSize(const wxULongLong& sz, const wxString& nullsize = "Not available", int precision = 1, wxSizeConvention conv = wxSIZE_CONV_TRADITIONAL); // %override to remote _() as it's not handled by wxlua
//#endif // wxUSE_LONGLONG

};
#endif //wxLUA_USE_wxFileName

// ---------------------------------------------------------------------------
// wxFile

#if wxLUA_USE_wxFile && wxUSE_FILE

#include "wx/file.h"

// opening mode
enum wxFile::OpenMode
{
    read,
    write,
    read_write,
    write_append,
    write_excl
};

// standard values for file descriptor
enum wxFile::dummy
{
    fd_invalid, // = -1
    fd_stdin,
    fd_stdout,
    fd_stderr
};

class %delete wxFile
{
    wxFile();
    wxFile(const wxString& filename, wxFile::OpenMode mode = wxFile::read);

    // static functions
    // ----------------
    // check whether a regular file by this name exists
    static bool Exists(const wxString& name);
    
    // check whether we can access the given file in given mode
    // (only read and write make sense here)
    static bool Access(const wxString& name, wxFile::OpenMode mode);
  
    // open/close
    // create a new file (with the default value of bOverwrite, it will fail if
    // the file already exists, otherwise it will overwrite it and succeed)
    bool Create(const wxString& fileName, bool bOverwrite = false, int access = wxS_DEFAULT);

    bool Open(const wxString& filename, wxFile::OpenMode mode = wxFile::read, int access = wxS_DEFAULT);
    bool Close();  // Close is a NOP if not opened

    // assign an existing file descriptor and get it back from wxFile object
    void Attach(int lfd);
    int Detach();
    int fd() const;

    // read/write (unbuffered)
    // read all data from the file into a string (useful for text files)
    bool ReadAll(wxString *str); //, const wxMBConv& conv = wxConvAuto());
    
    // %override [size_t count, Lua string] wxFile::Read(unsigned int count);
    // C++ Func: ssize_t Read(void *pBuf, size_t nCount);
    // returns number of bytes read or wxInvalidOffset on error
    size_t Read(unsigned int count);
    
    // %override size_t wxFile::Write(Lua string, unsigned int count);
    // C++ Func: size_t Write(const void *pBuf, size_t nCount);
    // returns the number of bytes written
    size_t Write(const wxString& buffer, unsigned int count);

    // returns true on success
    bool Write(const wxString& s); //, const wxMBConv& conv = wxConvAuto());
    
    // flush data not yet written
    bool Flush();
    
    // file pointer operations (return wxInvalidOffset on failure)
    // move ptr ofs bytes related to start/current offset/end of file
    wxFileOffset Seek(wxFileOffset ofs, wxSeekMode mode = wxFromStart);
    
    // move ptr to ofs bytes before the end
    wxFileOffset SeekEnd(wxFileOffset ofs = 0);

    // get current offset
    wxFileOffset Tell() const;
    
    // get current file length
    wxFileOffset Length() const;

    // simple accessors
    // is file opened?
    bool IsOpened() const;
    
    // is end of file reached?
    bool Eof() const;
    
    // has an error occurred?
    bool Error() const;
    
    // get last errno
    int GetLastError() const;
    
    // reset error state
    void ClearLastError();
    
    // type such as disk or pipe
    wxFileKind GetKind() const;

};

// ---------------------------------------------------------------------------
// wxTempFile

#include "wx/file.h"

class %delete wxTempFile
{
    wxTempFile();
    
    // associates the temp file with the file to be replaced and opens it
    wxTempFile(const wxString& strName);
    
    // open the temp file (strName is the name of file to be replaced)
    bool Open(const wxString& strName);

    // is the file opened?
    bool IsOpened() const;
    
    // get current file length
    wxFileOffset Length() const;
    
    // move ptr ofs bytes related to start/current offset/end of file
    wxFileOffset Seek(wxFileOffset ofs, wxSeekMode mode = wxFromStart);
    
    // get current offset
    wxFileOffset Tell() const;

    // I/O (both functions return true on success, false on failure)
    //bool Write(const void *p, size_t n) { return m_file.Write(p, n) == n; }
    bool Write(const wxString& str); //, const wxMBConv& conv = wxMBConvUTF8());

    // flush data: can be called before closing file to ensure that data was
    // correctly written out
    bool Flush();

    // different ways to close the file
    // validate changes and delete the old file of name m_strName
    bool Commit();
    
    // discard changes
    void Discard();
    
};

#endif //wxLUA_USE_wxFile && wxUSE_FILE

// ---------------------------------------------------------------------------
// wxDir

#if wxLUA_USE_wxDir

#include "wx/dir.h"

#define wxDIR_FILES
#define wxDIR_DIRS
#define wxDIR_HIDDEN
#define wxDIR_DOTDOT
#define wxDIR_NO_FOLLOW
#define wxDIR_DEFAULT

// these constants are possible return value of wxDirTraverser::OnDir()
enum wxDirTraverseResult
{
    wxDIR_IGNORE,           // ignore this directory but continue with others
    wxDIR_STOP,             // stop traversing
    wxDIR_CONTINUE          // continue into this directory
};

class %delete wxDir
{
    wxDir();
    wxDir(const wxString& dir);
    void Close();
    static bool Exists(const wxString& dir);
    static wxString FindFirst(const wxString& dirname, const wxString& filespec, int flags = wxDIR_DEFAULT);
    wxString GetName() const;
    wxString GetNameWithSep() const;
    bool HasFiles(const wxString& filespec = "");
    bool HasSubDirs(const wxString& dirspec = "");
    bool IsOpened() const;
    static bool Make(const wxString &dir, int perm = wxS_DIR_DEFAULT, int flags = 0);
    bool Open(const wxString& dir);
    static bool Remove(const wxString &dir, int flags = 0);
    // size_t Traverse(wxDirTraverser& sink, const wxString& filespec = wxEmptyString, int flags = wxDIR_DEFAULT);
    static wxULongLong GetTotalSize(const wxString &dir); // %override ..., wxArrayString *filesSkipped = NULL)
    bool GetFirst(const wxString& filespec = "", int flags = wxDIR_DEFAULT) const; // %override return [bool, string filename]
    bool GetNext() const; // %override return [bool, string filename]
    static unsigned int GetAllFiles(const wxString& dirname, const wxString& filespec = "", int flags = wxDIR_DEFAULT); // %override return [unsigned int, Lua string table]
};

#endif //wxLUA_USE_wxDir

// ---------------------------------------------------------------------------
//  wxFileTypeInfo

#include "wx/mimetype.h"

class %delete wxFileTypeInfo
{
    //  the ... parameters form a NULL terminated list of extensions
    //wxFileTypeInfo(const wxChar *mimeType, const wxChar *openCmd, const wxChar *printCmd, const wxChar *desc, ...);
    // the array elements correspond to the parameters of the ctor above in the same order
    wxFileTypeInfo(const wxArrayString& sArray);

    // invalid item - use this to terminate the array passed to wxMimeTypesManager::AddFallbacks
    wxFileTypeInfo();

    bool IsValid() const;

    void SetIcon(const wxString& iconFile, int iconIndex = 0);
    void SetShortDesc(const wxString& shortDesc);

    wxString GetMimeType() const;
    wxString GetOpenCommand() const;
    wxString GetPrintCommand() const;
    wxString GetShortDesc() const;
    wxString GetDescription() const;
    wxArrayString GetExtensions() const;
    size_t GetExtensionsCount() const;
    wxString GetIconFile() const;
    int GetIconIndex() const;
};

// ---------------------------------------------------------------------------
// wxIconLocation

#include "wx/iconloc.h"

class %delete wxIconLocation
{
    // ctor takes the name of the file where the icon is
    !%msw wxIconLocation(const wxString& filename = "");
    %msw wxIconLocation(const wxString& file = "", int num = 0);

    // returns true if this object is valid/initialized
    bool IsOk() const;

    // set/get the icon file name
    void SetFileName(const wxString& filename);
    const wxString& GetFileName() const;

    // set/get the icon index
    %msw void SetIndex(int num);
    %msw int GetIndex() const;
};

// ---------------------------------------------------------------------------
//  wxFileType::MessageParameters

class %delete wxFileType::MessageParameters
{
    //wxFileType::MessageParameters();
    wxFileType::MessageParameters(const wxString& filename, const wxString& mimetype = "");

    // accessors (called by GetOpenCommand);
    wxString GetFileName() const;
    wxString GetMimeType() const;

    // override this function in derived class
    virtual wxString GetParamValue(const wxString& name) const;
};

// ---------------------------------------------------------------------------
//  wxFileType

class %delete wxFileType
{
    wxFileType(const wxFileTypeInfo& ftInfo);

    // accessors: all of them return true if the corresponding information
    // could be retrieved/found, false otherwise (and in this case all [out] parameters are unchanged);

    // return the MIME type for this file type
    //bool GetMimeType(wxString *mimeType) const;
    bool GetMimeTypes(wxArrayString& mimeTypes) const;

    bool GetExtensions(wxArrayString& extensions);

    // get the icon corresponding to this file type and of the given size
    bool GetIcon(wxIconLocation *iconloc) const;
    //bool GetIcon(wxIconLocation *iconloc, const wxFileType::MessageParameters& params) const;

    // get a brief file type description ("*.txt" => "text document");
    // %override [bool Lua string] wxFileType::GetDescription() const;
    // C++ Func: bool GetDescription(wxString *desc) const;
    bool GetDescription() const;

    // get the command to be used to open/print the given file.
    //bool GetOpenCommand(wxString *openCmd, const wxFileType::MessageParameters& params) const;
    // a simpler to use version of GetOpenCommand() -- it only takes the
    // filename and returns an empty string on failure
    wxString GetOpenCommand(const wxString& filename) const;

    // get the command to print the file of given type
    // %override [bool Lua string] wxFileType::GetPrintCommand(const wxFileType::MessageParameters& params) const;
    // C++ Func: bool GetPrintCommand(wxString *printCmd, const wxFileType::MessageParameters& params) const;
    bool GetPrintCommand(const wxFileType::MessageParameters& params) const;

    // return the number of commands defined for this file type, 0 if none
    size_t GetAllCommands(wxArrayString *verbs, wxArrayString *commands, const wxFileType::MessageParameters& params) const;

    // set an arbitrary command, ask confirmation if it already exists and overwriteprompt is true
    bool SetCommand(const wxString& cmd, const wxString& verb, bool overwriteprompt = true);

    bool SetDefaultIcon(const wxString& cmd = "", int index = 0);

    // remove the association for this filetype from the system MIME database:
    // notice that it will only work if the association is defined in the user
    // file/registry part, we will never modify the system-wide settings
    bool Unassociate();

    // expand a string in the format of GetOpenCommand (which may contain
    // '%s' and '%t' format specificators for the file name and mime type
    // and %{param} constructions).
    static wxString ExpandCommand(const wxString& command, const wxFileType::MessageParameters& params);
};

// ---------------------------------------------------------------------------
//  wxMimeTypesManager

class wxMimeTypesManager
{
    #define_pointer wxTheMimeTypesManager

    // wxMimeTypesManager(); - Use pointer wxTheMimeTypesManager

    // check if the given MIME type is the same as the other one: the
    // second argument may contain wildcards ('*'), but not the first. If
    // the types are equal or if the mimeType matches wildcard the function
    // returns true, otherwise it returns false
    static bool IsOfType(const wxString& mimeType, const wxString& wildcard);

    // NB: the following 2 functions are for Unix only and don't do anything elsewhere

    // loads data from standard files according to the mailcap styles
    // specified: this is a bitwise OR of wxMailcapStyle values
    //
    // use the extraDir parameter if you want to look for files in another
    // directory
    void Initialize(int mailcapStyle = wxMAILCAP_ALL, const wxString& extraDir = "");
    // and this function clears all the data from the manager
    void ClearData();

    // Database lookup: all functions return a pointer to wxFileType object
    // whose methods may be used to query it for the information you're
    // interested in. If the return value is !NULL, caller is responsible for
    // deleting it.
    // get file type from file extension
    wxFileType *GetFileTypeFromExtension(const wxString& ext);
    // get file type from MIME type (in format <category>/<format>);
    wxFileType *GetFileTypeFromMimeType(const wxString& mimeType);

    // enumerate all known MIME types returns the number of retrieved file types
    size_t EnumAllFileTypes(wxArrayString& mimetypes);

    // The filetypes array should be terminated by either NULL entry or an
    // invalid wxFileTypeInfo (i.e. the one created with default ctor);
    //void AddFallbacks(const wxFileTypeInfo *filetypes);
    void AddFallback(const wxFileTypeInfo& ft);

    // create a new association using the fields of wxFileTypeInfo (at least
    // the MIME type and the extension should be set);
    // if the other fields are empty, the existing values should be left alone
    wxFileType *Associate(const wxFileTypeInfo& ftInfo);

    // undo Associate();
    bool Unassociate(wxFileType *ft);
};

// ---------------------------------------------------------------------------
//  wxStreamBase

#if wxUSE_STREAMS

#include "wx/stream.h"
#include "wx/txtstrm.h"

enum wxEOL
{
    wxEOL_NATIVE,
    wxEOL_UNIX,
    wxEOL_MAC,
    wxEOL_DOS
};

enum wxStreamError
{
    wxSTREAM_NO_ERROR,
    wxSTREAM_EOF,
    wxSTREAM_WRITE_ERROR,
    wxSTREAM_READ_ERROR
};

// ---------------------------------------------------------------------------
//  wxStreamBase

class wxStreamBase
{
    // wxStreamBase() this is only a base class

    wxFileOffset GetLength() const;
    wxStreamError GetLastError() const;
    size_t GetSize() const;
    bool IsOk() const;
    bool IsSeekable() const;
    void Reset();
};

// ---------------------------------------------------------------------------
//  wxInputStream

class wxInputStream : public wxStreamBase
{
    // wxInputStream() this is only a base class

    bool CanRead() const;
    char GetC();
    bool Eof();
    size_t LastRead() const;
    char Peek();

    // %override [Lua string] wxInputStream::Read(size_t size);
    // C++ Func: wxInputStream& Read(void *buffer, size_t size);
    wxString Read(size_t size);

    wxInputStream& Read(wxOutputStream& stream_in);
    wxFileOffset SeekI(wxFileOffset pos, wxSeekMode mode = wxFromStart);
    wxFileOffset TellI() const;

    // %override size_t wxInputStream::Ungetch(Lua string, size_t size);
    // C++ Func: size_t Ungetch(const char* buffer, size_t size);
    %override_name wxLua_wxInputStream_UngetchString size_t Ungetch(const wxString& str, size_t size);

    bool Ungetch(char c);
};

// ---------------------------------------------------------------------------
//  wxOutputStream

class wxOutputStream : public wxStreamBase
{
    // wxOutputStream() this is only a base class

    bool Close();
    size_t LastWrite() const;
    void PutC(char c);
    wxFileOffset SeekO(wxFileOffset pos, wxSeekMode mode = wxFromStart);
    wxFileOffset TellO() const;

    // %override wxOutputStream& wxOutputStream::Write(Lua string, size_t size);
    // C++ Func: wxOutputStream& Write(const void *buffer, size_t size);
    wxOutputStream& Write(const wxString& buffer, size_t size);

    wxOutputStream& Write(wxInputStream& stream_in);
};

// ---------------------------------------------------------------------------
//  wxFileInputStream

#include "wx/wfstream.h"

class %delete wxFileInputStream : public wxInputStream
{
    wxFileInputStream(const wxString& fileName);
    wxFileInputStream(wxFile& file);
    //wxFileInputStream(int fd);

    bool Ok() const;
};

// ---------------------------------------------------------------------------
//  wxFileOutputStream

class %delete wxFileOutputStream : public wxOutputStream
{
    wxFileOutputStream(const wxString& fileName);
    wxFileOutputStream(wxFile& file);
    //wxFileOutputStream(int fd);

    bool Ok() const;
};

// ---------------------------------------------------------------------------
//  wxMemoryInputStream

#include "wx/mstream.h"

class %delete wxMemoryInputStream : public wxInputStream
{
    wxMemoryInputStream(const char *data, size_t length);
    //wxMemoryInputStream(const wxMemoryOutputStream& stream);

};

// ---------------------------------------------------------------------------
//  wxMemoryOutputStream

//%include "wx/mstream.h"

//class %delete wxMemoryInputStream : public wxInputStream
//{
//    wxMemoryOutputStream(void *data, size_t length);
//    wxMemoryInputStream(const wxMemoryOutputStream& stream);
//};

// ---------------------------------------------------------------------------
//  wxDataInputStream

#include "wx/datstrm.h"

class %delete wxDataInputStream
{
    // wxDataInputStream(wxInputStream& s, const wxMBConv& conv = wxConvAuto());
    wxDataInputStream(wxInputStream& s);

    bool IsOk();

    //#if wxHAS_INT64
    //    wxUint64 Read64();
    //#endif
    //#if wxUSE_LONGLONG
    //    wxLongLong ReadLL();
    //#endif
    wxUint32 Read32();
    wxUint16 Read16();
    wxUint8 Read8();
    double ReadDouble();
    wxString ReadString();

    //#if wxHAS_INT64
    //   void Read64(wxUint64 *buffer, size_t size);
    //    void Read64(wxInt64 *buffer, size_t size);
    //#endif
    //#if defined(wxLongLong_t) && wxUSE_LONGLONG
    //    void Read64(wxULongLong *buffer, size_t size);
    //    void Read64(wxLongLong *buffer, size_t size);
    //#endif
    //#if wxUSE_LONGLONG
    //  void ReadLL(wxULongLong *buffer, size_t size);
    //  void ReadLL(wxLongLong *buffer, size_t size);
    //#endif
    //void Read32(wxUint32 *buffer, size_t size);
    //void Read16(wxUint16 *buffer, size_t size);
    //void Read8(wxUint8 *buffer, size_t size);
    //void ReadDouble(double *buffer, size_t size);

    void BigEndianOrdered(bool be_order);
};

// ---------------------------------------------------------------------------
//  wxDataOutputStream

#include "wx/datstrm.h"

class %delete wxDataOutputStream
{
    // wxDataOutputStream(wxOutputStream& s, const wxMBConv& conv = wxConvAuto());
    wxDataOutputStream(wxOutputStream& s);

    bool IsOk();

    //#if wxHAS_INT64
    //  void Write64(wxUint64 i);
    //  void Write64(wxInt64 i);
    //#endif
    //#if wxUSE_LONGLONG
    //    void WriteLL(const wxLongLong &ll);
    //    void WriteLL(const wxULongLong &ll);
    //#endif
    void Write32(wxUint32 i);
    void Write16(wxUint16 i);
    void Write8(wxUint8 i);
    void WriteDouble(double d);
    void WriteString(const wxString& string);

    //#if wxHAS_INT64
    //    void Write64(const wxUint64 *buffer, size_t size);
    //    void Write64(const wxInt64 *buffer, size_t size);
    //#endif
    //#if defined(wxLongLong_t) && wxUSE_LONGLONG
    //    void Write64(const wxULongLong *buffer, size_t size);
    //    void Write64(const wxLongLong *buffer, size_t size);
    //#endif
    //#if wxUSE_LONGLONG
    //    void WriteLL(const wxULongLong *buffer, size_t size);
    //    void WriteLL(const wxLongLong *buffer, size_t size);
    //#endif
    //void Write32(const wxUint32 *buffer, size_t size);
    //void Write16(const wxUint16 *buffer, size_t size);
    //void Write8(const wxUint8 *buffer, size_t size);
    //void WriteDouble(const double *buffer, size_t size);

    void BigEndianOrdered(bool be_order);
};



// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
//  wxFSFile

#if wxUSE_FILESYSTEM // already has wxUSE_STREAMS

#include "wx/filesys.h"


class %delete wxFSFile : public wxObject
{
    wxFSFile(%ungc wxInputStream *stream, const wxString& loc, const wxString& mimetype, const wxString& anchor, wxDateTime modif);

    // returns stream. This doesn't give away ownership of the stream object.
    wxInputStream *GetStream() const;
    // gives away the ownership of the current stream.
    %gc wxInputStream *DetachStream();
    // deletes the current stream and takes ownership of another.
    void SetStream(%ungc wxInputStream *stream);

    // returns file's mime type
    wxString GetMimeType() const;
    // returns the original location (aka filename) of the file
    wxString GetLocation() const;
    wxString GetAnchor() const;
    wxDateTime GetModificationTime() const;
};


// ---------------------------------------------------------------------------
//  wxFileSystemHandler

class %delete wxFileSystemHandler : public wxObject
{
    // wxFileSystemHandler(); // no constructor since it has abstract functions

    // returns true if this handler is able to open given location
    virtual bool CanOpen(const wxString& location); //= 0;

    // opens given file and returns pointer to input stream.
    // Returns NULL if opening failed.
    // The location is always absolute path.
    virtual wxFSFile* OpenFile(wxFileSystem& fs, const wxString& location); //= 0;

    // Finds first/next file that matches spec wildcard. flags can be wxDIR for restricting
    // the query to directories or wxFILE for files only or 0 for either.
    // Returns filename or empty string if no more matching file exists
    virtual wxString FindFirst(const wxString& spec, int flags = 0);
    virtual wxString FindNext();
};


// ---------------------------------------------------------------------------
//  wxLocalFSHandler


class %delete wxLocalFSHandler : public wxFileSystemHandler
{
    wxLocalFSHandler();

    // wxLocalFSHandler will prefix all filenames with 'root' before accessing
    // files on disk. This effectively makes 'root' the top-level directory
    // and prevents access to files outside this directory.
    // (This is similar to Unix command 'chroot'.);
    static void Chroot(const wxString& root);
};


// ---------------------------------------------------------------------------
//  wxFileSystem

enum
{
    wxFS_READ,        // Open for reading
    wxFS_SEEKABLE    // Returned stream will be seekable
};

class %delete wxFileSystem : public wxObject
{
    wxFileSystem();

    // sets the current location. Every call to OpenFile is
    // relative to this location.
    // NOTE !!
    // unless is_dir = true 'location' is *not* the directory but
    // file contained in this directory
    // (so ChangePathTo("dir/subdir/xh.htm") sets m_Path to "dir/subdir/");
    void ChangePathTo(const wxString& location, bool is_dir = false);

    wxString GetPath() const;

    // opens given file and returns pointer to input stream.
    // Returns NULL if opening failed.
    // It first tries to open the file in relative scope
    // (based on ChangePathTo()'s value) and then as an absolute
    // path.
    %gc wxFSFile* OpenFile(const wxString& location, int flags = wxFS_READ);

    // Finds first/next file that matches spec wildcard. flags can be wxDIR for restricting
    // the query to directories or wxFILE for files only or 0 for either.
    // Returns filename or empty string if no more matching file exists
    wxString FindFirst(const wxString& spec, int flags = 0);
    wxString FindNext();

    // find a file in a list of directories, returns false if not found
    // %override [bool, Lua string full_path] bool FindFileInPath(const wxString& path, const wxString& file);
    // C++ Func: bool FindFileInPath(wxString *pStr, const wxChar *path, const wxChar *file);
    bool FindFileInPath(const wxString& path, const wxString& file);

    // Adds FS handler.
    // In fact, this class is only front-end to the FS handlers :-);
    static void AddHandler(%ungc wxFileSystemHandler *handler);

    // Removes FS handler
    static %gc wxFileSystemHandler* RemoveHandler(wxFileSystemHandler *handler);

    // Returns true if there is a handler which can open the given location.
    static bool HasHandlerForPath(const wxString& location);

    // remove all items from the m_Handlers list
    static void CleanUpHandlers();

    // Returns the native path for a file URL
    static wxFileName URLToFileName(const wxString& url);

    // Returns the file URL for a native path
    static wxString FileNameToURL(const wxFileName& filename);
};


// ---------------------------------------------------------------------------
//  wxArchiveFSHandler

#include "wx/fs_arc.h"

class %delete wxArchiveFSHandler : public wxFileSystemHandler
{
    wxArchiveFSHandler();
};

// ---------------------------------------------------------------------------
//  wxZipFSHandler - is just a typedef to wxArchiveFSHandler

//%include "wx/fs_zip.h"

//#if wxUSE_FS_ZIP
//    typedef wxArchiveFSHandler wxZipFSHandler;
//#endif

// ---------------------------------------------------------------------------
//  wxFilterFSHandler

#include "wx/fs_filter.h"

class %delete wxFilterFSHandler : public wxFileSystemHandler
{
    wxFilterFSHandler();
};

// ---------------------------------------------------------------------------
//  wxInternetFSHandler

#if wxUSE_FS_INET && wxUSE_SOCKETS // already has wxUSE_STREAMS && wxUSE_FILESYSTEM
#include "wx/fs_inet.h"

class %delete wxInternetFSHandler : public wxFileSystemHandler
{
    wxInternetFSHandler();
};
#endif //wxUSE_FS_INET && wxUSE_SOCKETS

// ---------------------------------------------------------------------------
//  wxMemoryFSHandler - See wxcore_core.i for this since it requires wxImage & wxBitmap.


#endif // wxUSE_FILESYSTEM


#endif // wxUSE_STREAMS

// ---------------------------------------------------------------------------
//  wxFileSystemWatcher classes

#if wxUSE_FSWATCHER

#include "wx/fswatcher.h"

enum
{
    wxFSW_EVENT_CREATE, // = 0x01,
    wxFSW_EVENT_DELETE, // = 0x02,
    wxFSW_EVENT_RENAME, // = 0x04,
    wxFSW_EVENT_MODIFY, // = 0x08,
    wxFSW_EVENT_ACCESS, // = 0x10,
    wxFSW_EVENT_ATTRIB, // = 0x20, // Currently this is wxGTK-only

    // error events
    wxFSW_EVENT_WARNING, // = 0x40,
    wxFSW_EVENT_ERROR, // = 0x80,
    wxFSW_EVENT_ALL, // = wxFSW_EVENT_CREATE | wxFSW_EVENT_DELETE |
                     //    wxFSW_EVENT_RENAME | wxFSW_EVENT_MODIFY |
                     //    wxFSW_EVENT_ACCESS | wxFSW_EVENT_ATTRIB |
                     //    wxFSW_EVENT_WARNING | wxFSW_EVENT_ERROR
#if defined(wxHAS_INOTIFY)
    wxFSW_EVENT_UNMOUNT, // = 0x2000
#endif
};

// Type of the path watched, used only internally for now.
enum wxFSWPathType
{
    wxFSWPath_None,     // Invalid value for an initialized watch.
    wxFSWPath_File,     // Plain file.
    wxFSWPath_Dir,      // Watch a directory and the files in it.
    wxFSWPath_Tree      // Watch a directory and all its children recursively.
};

// Type of the warning for the events notifying about them.
enum wxFSWWarningType
{
    wxFSW_WARNING_NONE,
    wxFSW_WARNING_GENERAL,
    wxFSW_WARNING_OVERFLOW
};

// ---------------------------------------------------------------------------
// wxFileSystemWatcherEvent

class %delete wxFileSystemWatcherEvent: public wxEvent
{
public:
    %wxEventType wxEVT_FSWATCHER   // EVT_FSWATCHER(winid, func);

    wxFileSystemWatcherEvent(int changeType = 0, int watchid = wxID_ANY);
    wxFileSystemWatcherEvent(int changeType, wxFSWWarningType warningType, const wxString& errorMsg = "", int watchid = wxID_ANY);
    wxFileSystemWatcherEvent(int changeType, const wxFileName& path, const wxFileName& newPath, int watchid = wxID_ANY);

    const wxFileName& GetPath() const;
    void SetPath(const wxFileName& path);
    const wxFileName& GetNewPath() const;
    void SetNewPath(const wxFileName& path);
    int GetChangeType() const;
    //virtual wxEvent* Clone() const;
    //virtual wxEventCategory GetEventCategory() const;
    bool IsError() const;
    wxString GetErrorDescription() const;
    wxFSWWarningType GetWarningType() const;
    wxString ToString() const;
};

// ---------------------------------------------------------------------------
// wxFileSystemWatcher

class wxFileSystemWatcher : public wxEvtHandler
{
public:
    wxFileSystemWatcher();

    virtual bool Add(const wxFileName& path, int events = wxFSW_EVENT_ALL);
    bool AddAny(const wxFileName& path, int events, wxFSWPathType type, const wxString& filespec = "");
    virtual bool AddTree(const wxFileName& path, int events = wxFSW_EVENT_ALL, const wxString& filespec = wxEmptyString);
    virtual bool Remove(const wxFileName& path);
    virtual bool RemoveTree(const wxFileName& path);
    virtual bool RemoveAll();
    int GetWatchedPathsCount() const;
    int GetWatchedPaths(wxArrayString* paths) const;
    wxEvtHandler* GetOwner() const;
    void SetOwner(wxEvtHandler* handler);
};

#endif // wxUSE_FSWATCHER

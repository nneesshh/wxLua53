// ===========================================================================
// Purpose:     Various wxBase classes
// Author:      Ray Gilbert, John Labenski
// Created:     July 2004
// Copyright:   (c) Ray Gilbert
// Licence:     wxWidgets licence
// wxWidgets:   Updated to 2.8.4
// ===========================================================================

// ---------------------------------------------------------------------------
// wxWidgets version defines

#define wxMAJOR_VERSION
#define wxMINOR_VERSION
#define wxRELEASE_NUMBER
#define wxSUBRELEASE_NUMBER
#define_wxstring wxVERSION_STRING

bool wxCHECK_VERSION(int major, int minor, int release); // actually a define
bool wxCHECK_VERSION_FULL(int major, int minor, int release, int subrel); // actually a define

#define wxABI_VERSION

// ---------------------------------------------------------------------------
// wxWidgets platform defines

%__WINDOWS__       #define __WINDOWS__       1
%__WIN16__         #define __WIN16__         1
%__WIN32__         #define __WIN32__         1
%__WIN95__         #define __WIN95__         1
%__WXBASE__        #define __WXBASE__        1
%__WXCOCOA__       #define __WXCOCOA__       1
%__WXWINCE__       #define __WXWINCE__       1
%__WXGTK__         #define __WXGTK__         1
%__WXGTK12__       #define __WXGTK12__       1
%__WXGTK20__       #define __WXGTK20__       1
%__WXMOTIF__       #define __WXMOTIF__       1
%__WXMOTIF20__     #define __WXMOTIF20__     1
%__WXMAC__         #define __WXMAC__         1
%__WXMAC_CLASSIC__ #define __WXMAC_CLASSIC__ 1
%__WXMAC_CARBON__  #define __WXMAC_CARBON__  1
%__WXMAC_OSX__     #define __WXMAC_OSX__     1
%__WXMGL__         #define __WXMGL__         1
%__WXMSW__         #define __WXMSW__         1
%__WXOS2__         #define __WXOS2__         1
%__WXOSX__         #define __WXOSX__         1
%__WXPALMOS__      #define __WXPALMOS__      1
%__WXPM__          #define __WXPM__          1
%__WXSTUBS__       #define __WXSTUBS__       1
%__WXXT__          #define __WXXT__          1
%__WXX11__         #define __WXX11__         1
%__WXWINE__        #define __WXWINE__        1
%__WXUNIVERSAL__   #define __WXUNIVERSAL__   1
%__X__             #define __X__             1

// ---------------------------------------------------------------------------

/*  symbolic constant used by all Find()-like functions returning positive */
/*  integer on success as failure indicator */
#define wxNOT_FOUND //      (-1)

/* the default value for some length parameters meaning that the string is */
/* NUL-terminated */
#define wxNO_LEN // ((size_t)-1)

#include "wx/utils.h"

// Get OS description as a user-readable string
wxString wxGetOsDescription();

// %override [int version, int major, int minor, int micro] wxGetOsVersion();
// wxOperatingSystemId wxGetOsVersion(int *verMaj = NULL, int *verMin = NULL, int *verMicro = NULL);
// Get OS version
int wxGetOsVersion();

// Check is OS version is at least the specified major and minor version
bool wxCheckOsVersion(int majorVsn, int minorVsn = 0, int microVsn = 0);

// Get free memory in bytes, or -1 if cannot determine amount (e.g. on UNIX)
wxLongLong wxGetFreeMemory();

#if wxUSE_ON_FATAL_EXCEPTION
    bool wxHandleFatalExceptions(bool doIt = true);
#endif // wxUSE_ON_FATAL_EXCEPTION

// ----------------------------------------------------------------------------
// Environment variables
// ----------------------------------------------------------------------------

// %override [bool lua_string] wxGetEnv(const wxString& var);
// Returns success and the string environment variable.
// C++ Func: bool wxGetEnv(const wxString& var, wxString *value);
bool wxGetEnv(const wxString& var);

// set the env var name to the given value, return true on success
bool wxSetEnv(const wxString& var, const wxString& value);

// remove the env var from environment
bool wxUnsetEnv(const wxString& var);

// Retrieve the complete environment by filling specified map.
// Returns true on success or false if an error occurred.
//bool wxGetEnvMap(wxEnvVariableHashMap *map);

// ----------------------------------------------------------------------------
// Network and username functions.
// ----------------------------------------------------------------------------

// NB: "char *" functions are deprecated, use wxString ones!

// Get eMail address
//bool wxGetEmailAddress(wxChar *buf, int maxSize);
wxString wxGetEmailAddress();

// Get hostname.
//bool wxGetHostName(wxChar *buf, int maxSize);
wxString wxGetHostName();

// Get FQDN
wxString wxGetFullHostName();
//bool wxGetFullHostName(wxChar *buf, int maxSize);

// Get user ID e.g. jacs (this is known as login name under Unix)
//bool wxGetUserId(wxChar *buf, int maxSize);
wxString wxGetUserId();

// Get user name e.g. Julian Smart
//bool wxGetUserName(wxChar *buf, int maxSize);
wxString wxGetUserName();

// Get current Home dir and copy to dest (returns pstr->c_str())
wxString wxGetHomeDir();
//const wxChar* wxGetHomeDir(wxString *pstr);

// Get the user's (by default use the current user name) home dir,
// return empty string on error
wxString wxGetUserHome(const wxString& user = wxEmptyString);

// ---------------------------------------------------------------------------
// wxSystemOptions

#if wxLUA_USE_wxSystemOptions

#include "wx/sysopt.h"

class wxSystemOptions : public wxObject
{
    //wxSystemOptions(); // No constructor, all member functions static

    static wxString GetOption(const wxString& name) const;
    static int GetOptionInt(const wxString& name) const;
    static bool HasOption(const wxString& name) const;
    static bool IsFalse(const wxString& name) const;

    #if wxUSE_SYSTEM_OPTIONS
        static void SetOption(const wxString& name, const wxString& value);
        static void SetOption(const wxString& name, int value);
    #endif //wxUSE_SYSTEM_OPTIONS
};

#endif //wxLUA_USE_wxSystemOptions


// ---------------------------------------------------------------------------
// wxPlatformInfo

enum wxOperatingSystemId
{
    wxOS_UNKNOWN,                     // returned on error

    wxOS_MAC_OS,                      // Apple Mac OS 8/9/X with Mac paths
    wxOS_MAC_OSX_DARWIN,              // Apple Mac OS X with Unix paths
    wxOS_MAC,                         // wxOS_MAC_OS|wxOS_MAC_OSX_DARWIN,

    wxOS_WINDOWS_9X,                   // Windows 9x family (95/98/ME);
    wxOS_WINDOWS_NT,                   // Windows NT family (NT/2000/XP);
    wxOS_WINDOWS_MICRO,                // MicroWindows
    wxOS_WINDOWS_CE,                   // Windows CE (Window Mobile);
    wxOS_WINDOWS,                      //  wxOS_WINDOWS_9X|wxOS_WINDOWS_NT|wxOS_WINDOWS_MICRO|wxOS_WINDOWS_CE,

    wxOS_UNIX_LINUX,                    // Linux
    wxOS_UNIX_FREEBSD,                  // FreeBSD
    wxOS_UNIX_OPENBSD,                  // OpenBSD
    wxOS_UNIX_NETBSD,                   // NetBSD
    wxOS_UNIX_SOLARIS,                  // SunOS
    wxOS_UNIX_AIX,                      // AIX
    wxOS_UNIX_HPUX,                     // HP/UX
    wxOS_UNIX,                          // wxOS_UNIX_LINUX|wxOS_UNIX_FREEBSD|wxOS_UNIX_OPENBSD|wxOS_UNIX_NETBSD|wxOS_UNIX_SOLARIS|wxOS_UNIX_AIX|wxOS_UNIX_HPUX,

    wxOS_DOS,                           // Microsoft DOS
    wxOS_OS2                            // OS/2
};

enum wxPortId
{
    wxPORT_UNKNOWN,      // returned on error

    wxPORT_BASE,         // wxBase, no native toolkit used

    wxPORT_MSW,          // wxMSW, native toolkit is Windows API
    wxPORT_MOTIF,        // wxMotif, using [Open]Motif or Lesstif
    wxPORT_GTK,          // wxGTK, using GTK+ 1.x, 2.x, GPE or Maemo

    wxPORT_X11,          // wxX11, using wxUniversal
    wxPORT_PM,           // wxOS2, using OS/2 Presentation Manager
    wxPORT_OS2,          // wxOS2, using OS/2 Presentation Manager
    wxPORT_MAC,          // wxMac, using Carbon or Classic Mac API
    wxPORT_COCOA,        // wxCocoa, using Cocoa NextStep/Mac API
    wxPORT_WINCE,        // wxWinCE, toolkit is WinCE SDK API

    wxPORT_DFB           // wxDFB, using wxUniversal
};

enum wxArchitecture
{
    wxARCH_INVALID,         // returned on error

    wxARCH_32,              // 32 bit
    wxARCH_64,

    wxARCH_MAX
};

enum wxEndianness
{
    wxENDIAN_INVALID,           // returned on error

    wxENDIAN_BIG,               // 4321
    wxENDIAN_LITTLE,            // 1234
    wxENDIAN_PDP,               // 3412

    wxENDIAN_MAX
};

class wxPlatformInfo
{
    // No constructor, use static Get() function
    //wxPlatformInfo();
    //wxPlatformInfo(wxPortId pid, int tkMajor = -1, int tkMinor = -1, wxOperatingSystemId id = wxOS_UNKNOWN, int osMajor = -1, int osMinor = -1, wxArchitecture arch = wxARCH_INVALID, wxEndianness endian = wxENDIAN_INVALID, bool usingUniversal = false);

    // Gets a wxPlatformInfo already initialized with the values for
    // the currently running platform.
    //static const wxPlatformInfo& Get();
    static const wxPlatformInfo& Get();

    static wxOperatingSystemId GetOperatingSystemId(const wxString &name);
    static wxPortId GetPortId(const wxString &portname);

    static wxArchitecture GetArch(const wxString &arch);
    static wxEndianness GetEndianness(const wxString &end);

    static wxString GetOperatingSystemFamilyName(wxOperatingSystemId os);
    static wxString GetOperatingSystemIdName(wxOperatingSystemId os);
    static wxString GetPortIdName(wxPortId port, bool usingUniversal);
    static wxString GetPortIdShortName(wxPortId port, bool usingUniversal);

    static wxString GetArchName(wxArchitecture arch);
    static wxString GetEndiannessName(wxEndianness end);

    int GetOSMajorVersion() const;
    int GetOSMinorVersion() const;

    bool CheckOSVersion(int major, int minor) const;

    int GetToolkitMajorVersion() const;
    int GetToolkitMinorVersion() const;

    bool CheckToolkitVersion(int major, int minor) const;
    bool IsUsingUniversalWidgets() const;

    wxOperatingSystemId GetOperatingSystemId() const;
    wxPortId GetPortId() const;
    wxArchitecture GetArchitecture() const;
    wxEndianness GetEndianness() const;

    wxString GetOperatingSystemFamilyName() const;
    wxString GetOperatingSystemIdName() const;
    wxString GetPortIdName() const;
    wxString GetPortIdShortName() const;
    wxString GetArchName() const;
    wxString GetEndiannessName() const;

    void SetOSVersion(int major, int minor);
    void SetToolkitVersion(int major, int minor);
    void SetOperatingSystemId(wxOperatingSystemId n);
    void SetPortId(wxPortId n);
    void SetArchitecture(wxArchitecture n);
    void SetEndianness(wxEndianness n);

    bool IsOk() const;

    //bool operator==(const wxPlatformInfo &t) const; // we only use the wxWidget's wxPlatformInfo
    //bool operator!=(const wxPlatformInfo &t) const;
};


// ---------------------------------------------------------------------------
// wxSingleInstanceChecker

#if wxUSE_SNGLINST_CHECKER

#include "wx/snglinst.h"

class %delete wxSingleInstanceChecker
{
    wxSingleInstanceChecker(); // default ctor, use Create() after it
    // like Create() but no error checking (dangerous!);
    //wxSingleInstanceChecker(const wxString& name, const wxString& path = "");

    // name must be given and be as unique as possible, it is used as the mutex
    // name under Win32 and the lock file name under Unix -
    // wxTheApp->GetAppName() may be a good value for this parameter
    //
    // path is optional and is ignored under Win32 and used as the directory to
    // create the lock file in under Unix (default is wxGetHomeDir());
    //
    // returns false if initialization failed, it doesn't mean that another
    // instance is running - use IsAnotherRunning() to check it
    bool Create(const wxString& name, const wxString& path = "");

    bool IsAnotherRunning() const; // is another copy of this program already running?
};

#endif // wxUSE_SNGLINST_CHECKER


// ---------------------------------------------------------------------------
// wxLog - See GUI log bindings in wxcore_core.i

#if wxLUA_USE_wxLog && wxUSE_LOG

#include "wx/log.h"

// These functions are in log.h
unsigned long wxSysErrorCode();
wxString wxSysErrorMsg(unsigned long nErrCode = 0);

void wxSafeShowMessage(const wxString& title, const wxString& text);

// All of the wxLogXXX functions take only a single string,
// use string.format(...) to format the string in Lua.

// C++ Func: void wxLogError(const char *formatString, ...);
void wxLogError(const wxString& message);
// C++ Func: void wxLogFatalError(const char *formatString, ...);
void wxLogFatalError(const wxString& message);
// C++ Func: void wxLogWarning(const char *formatString, ...);
void wxLogWarning(const wxString& message);
// C++ Func: void wxLogMessage(const char *formatString, ...);
void wxLogMessage(const wxString& message);
// C++ Func: void wxLogVerbose(const char *formatString, ...);
void wxLogVerbose(const wxString& message);
// C++ Func: void wxLogStatus(wxFrame *frame, const char *formatString, ...);
// void wxLogStatus(const char *formatString, ...); // this just uses the toplevel frame, use wx.NULL for the frame
// IN wxCore void wxLogStatus(wxFrame *frame, const wxString& message);

// C++ Func: void wxLogSysError(const char *formatString, ...);
void wxLogSysError(const wxString& message);
// C++ Func: void wxLogDebug(const char *formatString, ...);
void wxLogDebug(const wxString& message);
// C++ Func: void wxLogTrace(const char *mask, const char *formatString, ...);
void wxLogTrace(const wxString& mask, const wxString& message);
// void wxLogTrace(const char *formatString, ...);
// void wxLogTrace(wxTraceMask mask, const char *formatString, ...) - deprecated

typedef unsigned long wxTraceMask
typedef unsigned long wxLogLevel

enum // wxLogLevel - uses these enums
{
    wxLOG_FatalError, // program can't continue, abort immediately
    wxLOG_Error,      // a serious error, user must be informed about it
    wxLOG_Warning,    // user is normally informed about it but may be ignored
    wxLOG_Message,    // normal message (i.e. normal output of a non GUI app);
    wxLOG_Status,     // informational: might go to the status line of GUI app
    wxLOG_Info,       // informational message (a.k.a. 'Verbose');
    wxLOG_Debug,      // never shown to the user, disabled in release mode
    wxLOG_Trace,      // trace messages are also only enabled in debug mode
    wxLOG_Progress,   // used for progress indicator (not yet);

    wxLOG_User,       // user defined levels start here
    wxLOG_Max
};

// symbolic trace masks - wxLogTrace("foo", "some trace message...") will be
// discarded unless the string "foo" has been added to the list of allowed
// ones with AddTraceMask();
#define_wxstring wxTRACE_MemAlloc //wxT("memalloc"); // trace memory allocation (new/delete);
#define_wxstring wxTRACE_Messages //wxT("messages"); // trace window messages/X callbacks
#define_wxstring wxTRACE_ResAlloc //wxT("resalloc"); // trace GDI resource allocation
#define_wxstring wxTRACE_RefCount //wxT("refcount"); // trace various ref counting operations
%msw #define_wxstring wxTRACE_OleCalls //wxT("ole"); // OLE interface calls

class %delete wxLog
{
    //wxLog() - No constructor, a base class, use one of the derived classes.

    // log messages selection
    // ----------------------

    // these functions allow to completely disable all log messages or disable
    // log messages at level less important than specified for the current
    // thread

    // is logging enabled at all now?
    static bool IsEnabled();
    
    // change the flag state, return the previous one
    static bool EnableLogging(bool enable = true);
    
    // return the current global log level
    static wxLogLevel GetLogLevel();

    // set global log level: messages with level > logLevel will not be logged
    static void SetLogLevel(wxLogLevel logLevel);

    // set the log level for the given component
    //static void SetComponentLevel(const wxString& component, wxLogLevel level);

    // return the effective log level for this component, falling back to
    // parent component and to the default global log level if necessary
    //
    // NB: component argument is passed by value and not const reference in an
    //     attempt to encourage compiler to avoid an extra copy: as we modify
    //     the component internally, we'd create one anyhow and like this it
    //     can be avoided if the string is a temporary anyhow
    //static wxLogLevel GetComponentLevel(wxString component);

    // is logging of messages from this component enabled at this level?
    //
    // usually always called with wxLOG_COMPONENT as second argument
    static bool IsLevelEnabled(wxLogLevel level, wxString component);

    // enable/disable messages at wxLOG_Verbose level (only relevant if the
    // current log level is greater or equal to it)
    //
    // notice that verbose mode can be activated by the standard command-line
    // '--verbose' option
    static void SetVerbose(bool bVerbose = true);

    // check if verbose messages are enabled
    static bool GetVerbose();
    
    // message buffering
    // -----------------

    // flush shows all messages if they're not logged immediately (FILE
    // and iostream logs don't need it, but wxLogGui does to avoid showing
    // 17 modal dialogs one after another)
    virtual void Flush();

    // flush the active target if any and also output any pending messages from
    // background threads
    static void FlushActive();

    // only one sink is active at each moment get current log target, will call
    // wxAppTraits::CreateLogTarget() to create one if none exists
    //
    // Don't delete the active target until you set a new one or set it to wx.NULL
    // Note, a new wxLog is created unless DontCreateOnDemand() is called.
    static wxLog *GetActiveTarget();

    // change log target, logger may be NULL
    // 
    // When you create a new wxLog and call "oldLog = SetActiveTarget(MyLog)"
    // the returned oldLog will be garbage collected or you can delete() the
    // oldLog unless you want to reuse it by calling "myLog = SetActiveTarget(oldLog)"
    // which releases myLog to be garbage collected or delete()ed by you.
    // Basicly, wxWidgets 'owns' the log you pass to SetActiveTarget() and
    // wxLua 'owns' the returned log.
    static %gc wxLog *SetActiveTarget(%ungc wxLog *pLogger);

//#if wxUSE_THREADS
    // change log target for the current thread only, shouldn't be called from
    // the main thread as it doesn't use thread-specific log target
//    static wxLog *SetThreadActiveTarget(wxLog *logger);
//#endif // wxUSE_THREADS

    // suspend the message flushing of the main target until the next call
    // to Resume() - this is mainly for internal use (to prevent wxYield()
    // from flashing the messages)
    static void Suspend();

    // must be called for each Suspend()!
    static void Resume();

    // should GetActiveTarget() try to create a new log object if the
    // current is NULL?
    static void DontCreateOnDemand();

    // Make GetActiveTarget() create a new log object again.
    static void DoCreateOnDemand();

    // log the count of repeating messages instead of logging the messages
    // multiple times
    static void SetRepetitionCounting(bool bRepetCounting = true);

    // gets duplicate counting status
    static bool GetRepetitionCounting();

    // add string trace mask
    static void AddTraceMask(const wxString& str);

    // add string trace mask
    static void RemoveTraceMask(const wxString& str);

    // remove all string trace masks
    static void ClearTraceMasks();

    // get string trace masks: note that this is MT-unsafe if other threads can
    // call AddTraceMask() concurrently
    static wxArrayString GetTraceMasks(); // not const wxArrayString since we copy it anyway

    // is this trace mask in the list?
    static bool IsAllowedTraceMask(const wxString& mask);
    
    // log formatting
    // -----------------

    // Change wxLogFormatter object used by wxLog to format the log messages.
    //
    // wxLog takes ownership of the pointer passed in but the caller is
    // responsible for deleting the returned pointer.
    //wxLogFormatter* SetFormatter(wxLogFormatter* formatter);


    // All the time stamp related functions below only work when the default
    // wxLogFormatter is being used. Defining a custom formatter overrides them
    // as it could use its own time stamp format or format messages without
    // using time stamp at all.

    // %override static void wxLog::SetTimestamp(const wxString& ts);
    // Allows an input of "nil" or no value to disable time stamping.
    // C++ Func: static void SetTimestamp(const wxString& ts)
    //
    // sets the time stamp string format: this is used as strftime() format
    // string for the log targets which add time stamps to the messages; set
    // it to empty string to disable time stamping completely.
    static void SetTimestamp(const wxString& ts);
    
    // disable time stamping of log messages
    static void DisableTimestamp()

    // get the current timestamp format string (maybe empty)
    static const wxString& GetTimestamp();

};

// ---------------------------------------------------------------------------
// wxLogBuffer

class %delete wxLogBuffer : public wxLog
{
    wxLogBuffer();

    const wxString& GetBuffer() const; // get the string contents with all messages logged
};

// ---------------------------------------------------------------------------
// wxLogChain

class %delete wxLogChain : public wxLog
{
    wxLogChain(wxLog *logger);

    void SetLog(wxLog *logger); // change the new log target
    // this can be used to temporarily disable (and then reenable) passing
    // messages to the old logger (by default we do pass them);
    void PassMessages(bool bDoPass);
    // are we passing the messages to the previous log target?
    bool IsPassingMessages() const;
    // return the previous log target (may be NULL);
    wxLog *GetOldLog() const;
};

// ---------------------------------------------------------------------------
// wxLogNull

class %delete wxLogNull // NOTE: this is not derived from wxLog
{
    // NOTE: ALWAYS delete() this when done since Lua's gc may not delete it soon enough
    wxLogNull();
};

// ---------------------------------------------------------------------------
// wxLogPassThrough - a chain log target which uses itself as the new logger

class %delete wxLogPassThrough : public wxLogChain
{
    wxLogPassThrough();
};

// ---------------------------------------------------------------------------
// wxLogStderr - FIXME need to implement FILE*

/*
class %delete wxLogStderr : public wxLog
{
    wxLogStderr(FILE *fp = (FILE *) NULL); // redirect log output to a FILE
};
*/

// ---------------------------------------------------------------------------
// wxLogStream - FIXME need to implement wxSTD ostream* (just use wxLogBuffer);

/*
#if wxUSE_STD_IOSTREAM

class %delete wxLogStream : public wxLog
{
    wxLogStream(wxSTD ostream *ostr = NULL); // redirect log output to an ostream
};

#endif // wxUSE_STD_IOSTREAM
*/

#endif // wxLUA_USE_wxLog && wxUSE_LOG

// ---------------------------------------------------------------------------
// wxDynamicLibrary - No a lot you can do with this, but it might make
//                    testing or debugging a C++ program easier to test thing
//                    out in wxLua first.

#if // wxLUA_USE_wxDynamicLibrary && wxUSE_DYNLIB_CLASS

#include "wx/dynlib.h"

enum wxDLFlags
{
    wxDL_LAZY,       // resolve undefined symbols at first use
                    // (only works on some Unix versions);
    wxDL_NOW,        // resolve undefined symbols on load
                    // (default, always the case under Win32);
    wxDL_GLOBAL,     // export extern symbols to subsequently
                    // loaded libs.
    wxDL_VERBATIM,   // attempt to load the supplied library
                    // name without appending the usual dll
                    // filename extension.
    wxDL_NOSHARE,    // load new DLL, don't reuse already loaded
                    // (only for wxPluginManager);

    wxDL_DEFAULT,    // = wxDL_NOW // default flags correspond to Win32
};

enum wxDynamicLibraryCategory
{
    wxDL_LIBRARY,       // standard library
    wxDL_MODULE         // loadable module/plugin
};

enum wxPluginCategory
{
    wxDL_PLUGIN_GUI,    // plugin that uses GUI classes
    wxDL_PLUGIN_BASE    // wxBase-only plugin
};


class %delete wxDynamicLibraryDetails
{
    // ctor, normally never used as these objects are only created by wxDynamicLibrary
    // wxDynamicLibrary::ListLoaded();
    //wxDynamicLibraryDetails() { m_address = NULL; m_length = 0; }

    wxString GetName() const; // get the (base) name
    wxString GetPath() const; // get the full path of this object

    // get the load address and the extent, return true if this information is available
    //bool GetAddress(void **addr, size_t *len) const;

    wxString GetVersion() const; // return the version of the DLL (may be empty if no version info);
};

class %delete wxDynamicLibraryDetailsArray
{
    //wxDynamicLibraryDetailsArray(); // Get this from wxDynamicLibrary::ListLoaded

    int  GetCount() const;
    wxDynamicLibraryDetails Item(int n);
};


class %delete wxDynamicLibrary
{
    wxDynamicLibrary();
    wxDynamicLibrary(const wxString& libname, int flags = wxDL_DEFAULT);

    // return a valid handle for the main program itself or NULL if back
    // linking is not supported by the current platform (e.g. Win32);
    //static wxDllType GetProgramHandle();

    // return the platform standard DLL extension (with leading dot);
    //static const wxChar *GetDllExt();
    static wxString GetDllExt();

    // return true if the library was loaded successfully
    bool IsLoaded() const;

    // load the library with the given name (full or not), return true if ok
    bool Load(const wxString& libname, int flags = wxDL_DEFAULT);

    // raw function for loading dynamic libs: always behaves as if
    // wxDL_VERBATIM were specified and doesn't log error message if the
    // library couldn't be loaded but simply returns NULL
    //static wxDllType RawLoad(const wxString& libname, int flags = wxDL_DEFAULT);

    // detach the library object from its handle, i.e. prevent the object from
    // unloading the library in its dtor -- the caller is now responsible for doing this
    //wxDllType Detach();

    // unload the given library handle (presumably returned by Detach() before);
    //static void Unload(wxDllType handle);

    // unload the library, also done automatically in dtor
    void Unload();

    // Return the raw handle from dlopen and friends.
    //wxDllType GetLibHandle() const; // { return m_handle; }

    // check if the given symbol is present in the library, useful to verify if
    // a loadable module is our plugin, for example, without provoking error
    // messages from GetSymbol();
    bool HasSymbol(const wxString& name) const;

    // resolve a symbol in a loaded DLL, such as a variable or function name.
    // 'name' is the (possibly mangled) name of the symbol. (use extern "C" to
    // export unmangled names);
    // Since it is perfectly valid for the returned symbol to actually be NULL,
    // that is not always indication of an error.  Pass and test the parameter
    // 'success' for a true indication of success or failure to load the symbol.
    // Returns a pointer to the symbol on success, or NULL if an error occurred
    // or the symbol wasn't found.
    //void *GetSymbol(const wxString& name, bool *success = NULL) const;

    // low-level version of GetSymbol();
    //static void *RawGetSymbol(wxDllType handle, const wxString& name);
    //void *RawGetSymbol(const wxString& name) const;

//#ifdef __WXMSW__
    // this function is useful for loading functions from the standard Windows
    // DLLs: such functions have an 'A' (in ANSI build) or 'W' (in Unicode, or
    // wide character build) suffix if they take string parameters
    //static void *RawGetSymbolAorW(wxDllType handle, const wxString& name);
    //void *GetSymbolAorW(const wxString& name) const;
//#endif // __WXMSW__

    // return all modules/shared libraries in the address space of this process
    // returns an empty array if not implemented or an error occurred
    static wxDynamicLibraryDetailsArray ListLoaded();

    // return platform-specific name of dynamic library with proper extension
    // and prefix (e.g. "foo.dll" on Windows or "libfoo.so" on Linux);
    static wxString CanonicalizeName(const wxString& name, wxDynamicLibraryCategory cat = wxDL_LIBRARY);

    // return name of wxWidgets plugin (adds compiler and version info
    // to the filename):
    static wxString CanonicalizePluginName(const wxString& name, wxPluginCategory cat = wxDL_PLUGIN_GUI);

    // return plugin directory on platforms where it makes sense and empty string on others:
    static wxString GetPluginsDirectory();
};

// ---------------------------------------------------------------------------
// wxPluginLibrary - You cannot use this within wxLua

// ---------------------------------------------------------------------------
// wxPluginManager - You cannot use this within wxLua

#endif // wxLUA_USE_wxDynamicLibrary && wxUSE_DYNLIB_CLASS


// ---------------------------------------------------------------------------
// wxCriticalSection

#if wxLUA_USE_wxCriticalSection && wxUSE_THREADS

#include "wx/thread.h"

class %delete wxCriticalSection
{
    wxCriticalSection();
    void Enter();
    void Leave();
};

#endif // wxLUA_USE_wxCriticalSection


// ---------------------------------------------------------------------------
// wxCriticalSectionLocker

#if wxLUA_USE_wxCriticalSectionLocker

#include "wx/thread.h"

class %delete wxCriticalSectionLocker
{
    wxCriticalSectionLocker(wxCriticalSection& cs);
};

#endif // wxLUA_USE_wxCriticalSectionLocker && wxUSE_THREADS


// ---------------------------------------------------------------------------
//  wxRegEx - Regular expression support

#if wxLUA_USE_wxRegEx && wxUSE_REGEX

#include "wx/regex.h"

enum
{
    wxRE_EXTENDED,
    wxRE_BASIC,
    wxRE_ICASE,
    wxRE_NOSUB,
    wxRE_NEWLINE,
    wxRE_DEFAULT
};

enum
{
    wxRE_NOTBOL,
    wxRE_NOTEOL
};

class %delete wxRegEx
{
    wxRegEx();
    wxRegEx(const wxString& expr, int flags = wxRE_DEFAULT);

    bool Compile(const wxString& pattern, int flags = wxRE_DEFAULT);
    bool IsValid() const;
    wxString GetMatch(const wxString& text, size_t index = 0) const;

    // %override [bool, size_t start, size_t len] wxRegEx::GetMatch(size_t index = 0) const;
    // C++ Func: bool GetMatch(size_t* start, size_t* len, size_t index = 0) const;
    %override_name wxLua_wxRegEx_GetMatchIndexes bool GetMatch(size_t index = 0) const;

    size_t GetMatchCount() const;
    // Note: only need this form of Matches
    bool Matches(const wxString &text, int flags = 0) const;

    // %override [int, string text] wxRegEx::Replace(const wxString& text, const wxString& replacement, size_t maxMatches = 0) const;
    // C++ Func: int Replace(wxString* text, const wxString& replacement, size_t maxMatches = 0) const;
    int Replace(const wxString& text, const wxString& replacement, size_t maxMatches = 0) const;

    // %override [int, string text] wxRegEx::ReplaceAll(const wxString& text, const wxString& replacement) const;
    // C++ Func: int ReplaceAll(wxString* text, const wxString& replacement) const;
    int ReplaceAll(const wxString& text, const wxString& replacement) const;

    // %override [int, string text] wxRegEx::ReplaceFirst(const wxString& text, const wxString& replacement) const;
    // C++ Func: int ReplaceFirst(wxString* text, const wxString& replacement) const;
    int ReplaceFirst(const wxString& text, const wxString& replacement) const;
};

#endif //wxLUA_USE_wxRegEx && wxUSE_REGEX

// ---------------------------------------------------------------------------
// wxEvtHandler

#include "wx/event.h"

class %delete wxEventLoopBase
{
    static wxEventLoopBase *GetActive();
    static void SetActive(wxEventLoopBase* loop);
    bool IsMain() const;
    int Run();
    bool IsRunning() const;
    bool IsOk() const;
    void Exit(int rc = 0);
    void ScheduleExit(int rc = 0);
    bool Pending() const;
    bool Dispatch();
    int DispatchTimeout(unsigned long timeout);
    void WakeUp();
    void WakeUpIdle();
    bool ProcessIdle();
    bool IsYielding() const;
    bool Yield(bool onlyIfNeeded = false);
    bool YieldFor(long eventsToProcess);
    bool IsEventAllowedInsideYield(wxEventCategory cat) const;
};

class wxEventFilter
{
    // wxEventFilter(); // no constructor as it's an abstract class
    int FilterEvent(wxEvent& event);
};

class %delete wxEvtHandler : public wxObject
{
    wxEvtHandler();
    virtual void QueueEvent(%ungc wxEvent *event);
    void AddPendingEvent(const wxEvent& event);
    virtual bool ProcessEvent(wxEvent& event);
    bool ProcessEventLocally(wxEvent& event);
    bool SafelyProcessEvent(wxEvent& event);
    void ProcessPendingEvents();
    void DeletePendingEvents();
    // void Connect(int id, int lastId, wxEventType eventType, wxObjectEventFunction function, wxObject* userData = NULL, wxEvtHandler* eventSink = NULL);
    // void Connect(int id, wxEventType eventType, wxObjectEventFunction function, wxObject* userData = NULL, wxEvtHandler* eventSink = NULL);
    // void Connect(wxEventType eventType, wxObjectEventFunction function, wxObject* userData = NULL, wxEvtHandler* eventSink = NULL);
    // void Bind(const EventTag& eventType, Functor functor, int id = wxID_ANY, int lastId = wxID_ANY, wxObject *userData = NULL);
    // bool Unbind(const EventTag& eventType, Functor functor, int id = wxID_ANY, int lastId = wxID_ANY, wxObject *userData = NULL);
    voidptr_long GetClientData(); // %override C++ returns (void *) You get a number here
    wxClientData* GetClientObject() const;
    void SetClientObject(wxClientData* data);
    bool GetEvtHandlerEnabled();
    wxEvtHandler* GetNextHandler();
    wxEvtHandler* GetPreviousHandler();
    void SetEvtHandlerEnabled(bool enabled);
    void SetNextHandler(wxEvtHandler* handler);
    void SetPreviousHandler(wxEvtHandler* handler);

    void Unlink();
    bool IsUnlinked() const;
    static void AddFilter(wxEventFilter* filter);
    static void RemoveFilter(wxEventFilter* filter);

    // bool SearchEventTable(wxEventTable& table, wxEvent& event); // no wxEventTable
    bool Disconnect(int id, int lastId, wxEventType eventType); // %override parameters
    void Connect(int id, int lastId, wxEventType eventType, LuaFunction func); // %add parameters
    void SetClientData(voidptr_long number); // %override C++ is (void *clientData) You can put a number here
};

// ---------------------------------------------------------------------------
// wxEvent

enum Propagation_state
{
    wxEVENT_PROPAGATE_NONE, // don't propagate it at all
    wxEVENT_PROPAGATE_MAX  // propagate it until it is processed
};

enum wxEventCategory
{
    /**
        This is the category for those events which are generated to update
        the appearance of the GUI but which (usually) do not comport data
        processing, i.e. which do not provide input or output data
        (e.g. size events, scroll events, etc).
        They are events NOT directly generated by the user's input devices.
    */
    wxEVT_CATEGORY_UI = 1,

    /**
        This category groups those events which are generated directly from the
        user through input devices like mouse and keyboard and usually result in
        data to be processed from the application
        (e.g. mouse clicks, key presses, etc).
    */
    wxEVT_CATEGORY_USER_INPUT = 2,

    /// This category is for wxSocketEvent
    wxEVT_CATEGORY_SOCKET = 4,

    /// This category is for wxTimerEvent
    wxEVT_CATEGORY_TIMER = 8,

    /**
        This category is for any event used to send notifications from the
        secondary threads to the main one or in general for notifications among
        different threads (which may or may not be user-generated).
        See e.g. wxThreadEvent.
    */
    wxEVT_CATEGORY_THREAD = 16,

    /**
        This mask is used in wxEventLoopBase::YieldFor to specify that all event
        categories should be processed.
    */
    wxEVT_CATEGORY_ALL =
        wxEVT_CATEGORY_UI|wxEVT_CATEGORY_USER_INPUT|wxEVT_CATEGORY_SOCKET| \
        wxEVT_CATEGORY_TIMER|wxEVT_CATEGORY_THREAD
};

class %delete wxEvent : public wxObject
{
    // wxEvent(int id = 0, wxEventType eventType = wxEVT_NULL); // no constructor as it's an abstract class
    // wxEvent* Clone() const; // no constructor as it's an abstract class
    wxObject* GetEventObject();
    wxEventType GetEventType();
    wxEventCategory GetEventCategory() const;
    int GetId();
    wxObject *GetEventUserData() const;
    bool GetSkipped();
    long GetTimestamp();
    bool IsCommandEvent() const;
    void ResumePropagation(int propagationLevel);
    void SetEventObject(wxObject* object);
    void SetEventType(wxEventType type);
    void SetId(int id);
    void SetTimestamp(long timeStamp);
    bool ShouldPropagate() const;
    void Skip(bool skip = true);
    int StopPropagation();
};

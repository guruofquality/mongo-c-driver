AC_MSG_CHECKING([whether to do a debug build])
AC_ARG_ENABLE(debug, 
    AC_HELP_STRING([--enable-debug], [turn on debugging [default=no]]),
    [],[enable_debug="no"])
AC_MSG_RESULT([$enable_debug])

AC_MSG_CHECKING([whether to enable optimized builds])
AC_ARG_ENABLE(optimizations, 
    AC_HELP_STRING([--enable-optimizations], [turn on build-time optimizations [default=yes]]),
    [enable_optimizations=$enableval],
    [
        if test "$enable_debug" = "yes"; then
            enable_optimizations="no";
        else
            enable_optimizations="yes";
        fi
    ])
AC_MSG_RESULT([$enable_optimizations])

AC_MSG_CHECKING([whether to enable code coverage support])
AC_ARG_ENABLE(coverage,
    AC_HELP_STRING([--enable-coverage], [enable code coverage support [default=no]]),
    [],
    [enable_coverage="no"])
AC_MSG_RESULT([$enable_coverage])

AC_MSG_CHECKING([whether to enable debug symbols])
AC_ARG_ENABLE(debug_symbols,
    AC_HELP_STRING([--enable-debug-symbols=yes|no|min|full], [enable debug symbols default=no, default=yes for debug builds]),
    [
        case "$enable_debug_symbols" in
            yes) enable_debug_symbols="full" ;;
            no|min|full) ;;
            *) AC_MSG_ERROR([Invalid debug symbols option: must be yes, no, min or full.]) ;;
        esac
    ],
    [
         if test "$enable_debug" = "yes"; then
             enable_debug_symbols="yes";
         else
             enable_debug_symbols="no";
         fi
    ])
AC_MSG_RESULT([$enable_debug_symbols])

AC_ARG_ENABLE([rdtscp],
              [AS_HELP_STRING([--enable-rdtscp=@<:@no/yes@:>@],
                              [Use rdtscp for per-cpu counters @<:@default=no@:>@])],
              [],
              [enable_rdtscp=no])

# use strict compiler flags only on development releases
m4_define([maintainer_flags_default], [m4_if(m4_eval(mongoc_minor_version % 2), [1], [yes], [no])])
AC_ARG_ENABLE([maintainer-flags],
              [AS_HELP_STRING([--enable-maintainer-flags=@<:@no/yes@:>@],
                              [Use strict compiler flags @<:@default=]maintainer_flags_default[@:>@])],
              [],
              [enable_maintainer_flags=maintainer_flags_default])


# Check if we should use the bundled (git submodule) libbson
AC_MSG_CHECKING([whether to use bundled libbson.])
AC_ARG_WITH(libbson,
    AC_HELP_STRING([--with-libbson=@<:@auto/system/bundled@:>@],
                   [use system installed libbson or bundled libbson. default=auto])
    [],
    [with_libbson=auto])
AS_IF([test "x$with_libbson" != "bundled" && test "x$with_libbson" != "system"],
      [with_libbson=auto])


AC_MSG_CHECKING([whether to enable SSL.])
AC_ARG_ENABLE([ssl],
              [AS_HELP_STRING([--enable-ssl=@<:@auto/yes/no@:>@],
                              [Use OpenSSL for TLS connections.])],
              [],
              [enable_ssl=auto])


AC_MSG_CHECKING([whether to enable SASL.])
AC_ARG_ENABLE([sasl],
              [AS_HELP_STRING([--enable-sasl=@<:@auto/yes/no@:>@],
                              [Use libsasl2 for Kerberos.])],
              [],
              [enable_sasl=auto])

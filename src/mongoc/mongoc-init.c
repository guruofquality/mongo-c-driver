/*
 * Copyright 2013 MongoDB, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include "mongoc-counters-private.h"
#include "mongoc-compat.h"

#include <bson.h>

#include "mongoc-config.h"

#ifdef MONGOC_ENABLE_SSL
#include "mongoc-ssl.h"
#include "mongoc-ssl-private.h"
#endif

#include "mongoc-init.h"

static MONGOC_ONCE_FUN( _mongoc_do_init)
{
#ifdef MONGOC_ENABLE_SSL
   _mongoc_ssl_init();
#endif
   _mongoc_counters_init();
   _mongoc_compat_init();

   MONGOC_ONCE_RETURN;
}

void
mongoc_init (void)
{
   static mongoc_once_t once = MONGOC_ONCE_INIT;
   mongoc_once (&once, _mongoc_do_init);
}


/*
 * On GCC, just use __attribute__((constructor)) to perform initialization
 * automatically for the application.
 */
#ifdef __GNUC__
static void _mongoc_init_ctor (void) __attribute__((constructor));
static void
_mongoc_init_ctor (void)
{
   mongoc_init ();
}
#endif

%% This Source Code Form is subject to the terms of the Mozilla Public
%% License, v. 2.0. If a copy of the MPL was not distributed with this
%% file, You can obtain one at https://mozilla.org/MPL/2.0/.
%%
%% Copyright (c) 2020 VMware, Inc. or its affiliates.  All rights reserved.

-module(terminfo).

-export([isatty/1,
         setupterm/1,
         setupterm/2,
         query_cap/1,
         query_all_caps/0]).

-type fdname() :: stdin | stdout | stderr.
-type capname() :: colors
                 | cols
                 | lines.
-type capvalue() :: integer().

-export_type([fdname/0,
              capname/0,
              capvalue/0]).

-spec isatty(fdname()) -> boolean().

isatty(FdName) ->
    terminfo_nifs:isatty(FdName).

-spec setupterm(fdname()) -> ok.

setupterm(FdName) ->
    setupterm("", FdName).

-spec setupterm(string(), fdname()) -> ok.

setupterm(Term, FdName) when is_list(Term) ->
    terminfo_nifs:setupterm(Term, FdName);
setupterm(Term, FdName) when is_binary(Term) ->
    setupterm(binary_to_list(Term), FdName).

-spec query_cap(capname()) -> capvalue().

query_cap(colors) -> terminfo_nifs:tigetnum("colors");
query_cap(cols)   -> terminfo_nifs:tigetnum("cols");
query_cap(lines)  -> terminfo_nifs:tigetnum("lines").

query_all_caps() ->
    #{colors => query_cap(colors),
      cols => query_cap(cols),
      lines => query_cap(lines)
     }.

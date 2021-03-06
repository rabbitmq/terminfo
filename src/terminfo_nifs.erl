%% This Source Code Form is subject to the terms of the Mozilla Public
%% License, v. 2.0. If a copy of the MPL was not distributed with this
%% file, You can obtain one at https://mozilla.org/MPL/2.0/.
%%
%% Copyright (c) 2020 VMware, Inc. or its affiliates.  All rights reserved.

-module(terminfo_nifs).

-export([isatty/1,
         setupterm/2,
         tigetnum/1,
         tigetflag/1,
         tigetstr/1]).

-include_lib("host_triple/include/code_loading.hrl").

-on_load(on_load/0).

on_load() ->
    ?load_nif_from_host_triple_dir(terminfo, atom_to_list(?MODULE), 0).

-spec isatty(terminfo:fdname()) -> boolean().

isatty(FdName)
  when FdName =:= stdin orelse
       FdName =:= stdout orelse
       FdName =:= stderr ->
    undefined.

-spec setupterm(string(), terminfo:fdname()) -> ok.

setupterm(Term, FdName)
  when is_list(Term) andalso
       (FdName =:= stdout orelse
        FdName =:= stderr) ->
    undefined.

-spec tigetnum(string()) -> integer().

tigetnum(CapName)
  when is_list(CapName) ->
    -1.

-spec tigetflag(string()) -> integer().

tigetflag(CapName)
  when is_list(CapName) ->
    -1.

-spec tigetstr(string()) -> string() | integer().

tigetstr(CapName)
  when is_list(CapName) ->
    "".

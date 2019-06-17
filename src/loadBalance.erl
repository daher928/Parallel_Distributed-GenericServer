%% @author Daher
%% @doc @todo Add description to loadBalance.

-module(loadBalance).

%% ====================================================================
%% API functions
%% ====================================================================
-export([startServers/0]).
-export([stopServers/0]).
-export([numberOfRunningFunctions/1]).
-export([calcFun/3]).

%% ====================================================================
%% Internal functions
%% ====================================================================
-export([min_load_server/0]).

%% ====================================================================
%% API functions Implementations
%% ====================================================================
startServers() -> 
	servers_supervisor:start_link().

stopServers() ->
	supervisor:terminate_child(servers_supervisor, server1),
	supervisor:terminate_child(servers_supervisor, server2),
	supervisor:terminate_child(servers_supervisor, server3),
	exit(whereis(servers_supervisor), normal).

numberOfRunningFunctions(ServerNumber) ->
	ServerName = case ServerNumber of
					 1 -> server1;
					 2 -> server2;
					 3-> server3
				 end,
	function_server:num_running_functions(ServerName).

calcFun(PID, F, MsgRef) ->
	Server = min_load_server(),
	function_server:calcFunction(Server, PID, F, MsgRef),
	ok.

%% ====================================================================
%% Internal functions implementation
%% ====================================================================

%% returns the server with least number of functions running
min_load_server() ->
	Server1_load = function_server:num_running_functions(server1),
	Server2_load = function_server:num_running_functions(server2),
	Server3_load = function_server:num_running_functions(server3),

	Loads = [Server1_load, Server2_load, Server3_load],
	ServerLoadMap = [{Server1_load,server1}, {Server2_load,server2}, {Server3_load,server3}],
	
	element(2, lists:keyfind(lists:min(Loads), 1, ServerLoadMap)).

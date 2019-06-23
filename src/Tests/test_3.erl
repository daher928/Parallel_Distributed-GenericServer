-module(test_3).

-compile(export_all).

start()->   
    loadBalance:startServers().

stop()->
    loadBalance:stopServers().

status(Time)->
    io:format("~p:Server 1 is handlling ~p tasks ~n",[Time,loadBalance:numberOfRunningFunctions(1)]),
    io:format("~p:Server 2 is handlling ~p tasks ~n",[Time,loadBalance:numberOfRunningFunctions(2)]),
    io:format("~p:Server 3 is handlling ~p tasks ~n",[Time,loadBalance:numberOfRunningFunctions(3)]).

whereare()->
    io:format("Server 1 pid is: ~p t~n",[whereis(server1)]),
    io:format("Server 2 pid is: ~p t~n",[whereis(server2)]),
    io:format("Server 3 pid is: ~p t~n",[whereis(server3)]).

battle()->
    compile:file(loadBalance),compile:file(servers_supervisor),compile:file(function_server), 
    F3 = fun()-> timer:sleep(3),3*3 end, 
    F5 = fun()-> timer:sleep(10000),4*4 end, 

    %Divide 10 functions: 
    whereare(),
	myLoop(F5,20),
	status(40),
    ok.
                
myLoop(_F,0)->
    ok;
myLoop(F,Times)->
    loadBalance:calcFun(self(),F,make_ref()),
    myLoop(F,Times-1).

sendExit()->
	FE = fun()-> exit(2) end,
	loadBalance:calcFun(self(), FE, ref),
	ok.

main()->
    start(),
    battle(),
    stop(),
    % c:flush(),
    ok_main.



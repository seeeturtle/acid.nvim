# acid.connections
low-level connection handler

## `add(this, addr)`
Stores connection for reuse later

this **(table)**: Connections object.

addr **({string,string})**: Address tuple with ip and port.


## `select(this, pwd, ix)`
Elects selected connection as primary (thus default) for a certain address

this **(table)**: Connections object.

pwd **(string)**: path (usually project root).
 Assumed to be neovim's `pwd`.

ix **(int)**: index of the stored connection


## `unselect(this, pwd)`
Dissociates the connection for the given path

this **(table)**: Connections object.

pwd **(string)**: path (usually project root).


## `get(this, pwd)`
Return active connection for the given path

this **(table)**: Connections object.

pwd **(string)**: path (usually project root).


**({string,string})** Connection tuple with ip and port.


---

# acid.core
low-level connection handler.

## `send([conn], obj, handler)`
Forward messages to the nrepl and registers the handler.

*conn* **({string,string})**: Ip and Port tuple. Will try to get one if nil.

obj **(table)**: Payload to be sent to the nrepl.

handler **(function)**: Handler function to deal with the response.


---

# acid.forms
Forms extraction

## `get_form_boundaries()`
Returns the coordinates for the boundaries of the current form


**(table)** coordinates {from = {row,col}, to = {row,col}}


## `form_under_cursor()`
Extracts the innermost form under the cursor


**(string)** symbol under cursor

**(table)** coordinates {from = {row,col}, to = {row,col}}


## `symbol_under_cursor()`
Extracts the symbol under the cursor


**(string)** symbol under cursor

**(table)** coordinates {from = {row,col}, to = {row,col}}


---

# acid
Frontend module with most relevant functions

## `connected([pwd])`
Checks whether a connection exists for supplied path or not.

*pwd* **(string)**: Path bound to connection.
 Will call `getcwd` on neovim if not supplied


**(boolean)** Whether a connection exists or not.


## `run(cmd, conn)`
Façade to core.send

cmd: A command (op + payload + handler) to be executed.

conn: A connection where this command will be run.


## `callback(session, ret)`
Callback proxy for handling command responses

session: Session ID for matching response with request

ret: The response from nrepl


---

# acid.nrepl
nRepl connectivity

## `middlewares`
List of supported middlewares and the wrappers to invoke when spawning a nrepl process.

Values:

* `[nrepl/nrepl]`

## `default_middlewares`
Default middlewares that will be used by the nrepl server

Values:

* `nrepl/nrepl`
* `cider/cider-nrepl`
* `refactor-nrepl`

## `start(obj)`
Starts a tools.deps nrepl server

obj **(table)**: Configuration for the nrepl process to be spawn

Parameters for table `obj` are:

* obj.pwd **(string)**: Path where the nrepl process will be started
* *obj.middlewares* **(table)**: List of middlewares.
* *obj.alias* **(string)**: alias on the local deps.edn
* *obj.connect* **(string)**: -c parameter for the nrepl process
* *obj.bind* **(string)**: -b parameter for the nrepl process

**(boolean)** Whether it was possible to spawn a nrepl process


## `stop(obj)`
Stops a nrepl process managed by acid

obj **(table)**: Configuration for the nrepl process to be stopped

Parameters for table `obj` are:

* obj.pwd **(string)**: Path where the nrepl process was started

## `show([ch])`
Debugs nrepl connection by returning the captured output

*ch* **(int)**: Neovim's job id of given nrepl process. When not supplied return all.


**(table)** table with the captured outputs for given (or all) nrepl process(es).

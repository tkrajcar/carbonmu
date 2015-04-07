[![Join the chat at https://gitter.im/tkrajcar/carbonmu](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/tkrajcar/carbonmu?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![Stories in Ready](https://badge.waffle.io/tkrajcar/carbonmu.png?label=ready&title=Ready)](https://waffle.io/tkrajcar/carbonmu)
[![Build Status](https://travis-ci.org/tkrajcar/carbonmu.png?branch=master)](https://travis-ci.org/tkrajcar/carbonmu)
[![Code Climate](https://codeclimate.com/github/tkrajcar/carbonmu.png)](https://codeclimate.com/github/tkrajcar/carbonmu)

# CarbonMU
CarbonMU is a general-purpose, extendable MUD/MUSH server framework written in Ruby. It's designed to scale to thousands of players, handle a wide variety of game types, from classic hack-n-slash MUDs to innovative text-based social communities. **CarbonMU is not ready for public use by non-developers, but we welcome user contributions to help move the project along**.

The remainder of this documentation is currently intended more as design documentation than how-tos.

## Where to talk about CarbonMU

* In the near future there will be an official CarbonMU support site running... CarbonMU. In the meantime, you can find me on M\*U\*S\*H (mush.pennmush.org 4201) as Rince.
* Use [Gitter](https://gitter.im/tkrajcar/carbonmu), a nifty chat system that integrates with Github.

## The road to 1.0

See [this wiki page](https://github.com/tkrajcar/carbonmu/wiki/The-road-to-1.0) for the latest updates on what's on the todo list. You are more than welcome to get involved! Feel free to open issues with questions, join discussions, or ask if you need help finding a task suitable for your interest and skill level.

## Architecture

CarbonMU is powered by [Celluloid](https://celluloid.io/), an actor-based concurrency/multithreading framework, plus [ZeroMQ](http://zeromq.org/) for inter-process communication, and uses MongoDB (via [Mongoid](http://mongoid.org/)) to store all of its data. The framework is designed to support a variety of connections, including basic TCP telnet, SSL telnet, and JSON over HTTP, API-style.

It's also intended to use a highly plugin-based model. A typical CarbonMU game will probably consist of the carbonmu core gem (what you see here), some number of community-supported third-party gems to provide things like a bboard system and other common utilities, and some game-specific custom code. It will not include a scripting engine or "softcode"-type functionality.

Internally, CarbonMU looks like this:

![architecture diagram](https://raw.githubusercontent.com/tkrajcar/carbonmu/master/doc/architecture.png)

The `EdgeRouter` and `Server` are separate actors. The `Server` can be therefore be restarted to load new game code without dropping TCP connections.

## Game objects

There are four built-in descendants of `GameObject` in core (modules may choose to add their own).
They are:

* `Room`, which mixes in `Container` so it can have contents
* `Thing`, something tangible that is in one and only one room (mixes in `Movable`), and also can have contents (is a `Container`)
* `Player`, similar to `Thing` except can be logged into, and will support more interactions (i.e. you can send in-game mail to a `Player`, but not a `Thing`). Includes `Movable` and `Container`.
* `Exit`, a connection between two `Room`s.

All of these are stored in MongoDB in the `game_objects` collection.

## Other data

Of course, MU*s need a lot more data than just things that can be interacted with. There'll be things like bboard messages, mail, and thousands of other things games will want to add for their custom needs. Plugins are welcome to declare their own classes that inherit `Mongoid::Document`, and can even reference the `GameObject` descendants. There's no need to create 'data objects' and store them there.

## Commands

Defining a new command is done by subclassing Command, adding one or more `syntax` calls using regular expressions with named captures for parameters, and providing an `execute` model that receives a `@params` hash with its named captures and a [CommandContext](https://github.com/tkrajcar/carbonmu/blob/master/lib/core/command_context.rb) instance in `@context`. See [lib/commands](https://github.com/tkrajcar/carbonmu/tree/master/lib/commands) for examples. This will continue to be fleshed out.

## Events

We will use a pubsub model (not yet implemented) to allow for both core functionality and people's gems to provide behavior when game events occur, as well as register their own events too.

## Building external plugins/modules/gems

This needs to be documented in detail once an example is done.

## Internationalization

CarbonMU will have full i18n support on a per-player basis, allowing each player to see game messages in their own locales (of course, chat messages and so on will not be auto-translated).

## Supported Rubies

## Setup

Clone the repo, start Mongo, bundle and run `rake console` to open an interactive
game console.

You can start a server with `carbonmu start`.

CarbonMU is supported on Ruby 2.0.x or newer, JRuby (latest release), and Rubinius (latest release). Using JRuby or Rubinius will allow your game to be multi-threaded.

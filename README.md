# Hashes of Hashes Lab

## Learning Goals

1. Recognize vocabulary term: "hash of hashes"
2. Recognize that "arrays of arrays" are trees
3. Create an `Hash` of `Hash`es
4. Read scalar data from an array of `Hash`es
5. Modify scalar data in an array of `Hash`es

## Introduction

Having worked with `Array`s of `Array`s and `Array`s of `Hash`es, you're going
to be pleasantly surprised that most of the syntax for `Hash`es of `Hash`es
(HoH) works like AoAs, but with `Hash` keys as the components of a coordinate.
Unlike an AoA where coordinates help you find a position in a grid, coordinates
in HoH can be stacked deeply so that you can tunnel deeply into a HoH.

### Key Image: Relationship Tree

To help you when reading the rest of this lesson, keep in mind that a HoH is
like a family tree. Every person in a family tree has two chromosomal parents.

We can render any given individual like so:

```ruby
{
  name: "",
  mother: {},
  father: {}
}
```

Notably, any `mother` value is, itself, a node that can have a `:mother` and
`:father` value. And this is true for each of those values, and each of those
values...and so on. You might see an infinite regress here. Because of the
potential to go infinitely deep, we'll keep our HoHs only one or two
generations wide.

(image)

### From Hash to Array of Hashes

Recall that an`Hash` is like a table, but in code form. It is a way for your
program to store pieces of data as elements in a collection. We call those
elements, in a `Hash`, the `Hash`'s _values_. We can point to each _value_ by
using a unique `String` or `Symbol` "lookup name" called a _key_. Arrays can
contain any combination of data types -- `Boolean`s, `Integer`s, `Strings`.

## Recognize Vocabulary Term: "Hash of Hashes"

HoH's property of being little "cells" who contain "cells" that are identical
to themselves makes them a very popular data structure to use in interviews or
when writing complex algorithms. There's no really special vocabulary to
recognize except that keys used are sometimes `:left` or `:right` versus
`:mother` or `:father`.

## Create a HoH

Let's make a simple family tree:

```ruby

# Simple Hashes
mother_hash = {
  name: "Debbie Reynolds",
  mother: {},
  father: {}
}

father_hash = {
  name: "Eddie Fisher",
  mother: {},
  father: {}
}

# Princess Leia (among other roles)
child = {
  name: "Carrie Fisher",
  mother: mother_hash,
  father: father_hash
} # => {:name=>"Carrie Fisher", :mother=>{:name=>"Debbie Reynolds", :mother=>{}, :father=>{}}, :father=>{:name=>"Eddie Fisher", :mother=>{}, :father=>{}}}
```

If we don't need to use `mother_hash` or `father_hash`, then we don't need to
assign them before nesting them in `child`.  We can write a nested AoH using
literal formatting:

```ruby
# AoH in one go
child = {:name=>"Carrie Fisher", :mother=>{:name=>"Debbie Reynolds", :mother=>{}, :father=>{}}, :father=>{:name=>"Eddie Fisher", :mother=>{}, :father=>{}}}

# Same as above, but using whitespace to make it easier for humans to read

child = {
  :name=>"Carrie Fisher",
  :mother=>{
    :name=>"Debbie Reynolds",
    :mother=>{},
    :father=>{}
  },
  :father=>{
    :name=>"Eddie Fisher",
    :mother=>{},
    :father=>{}
  }
}

```

Since Ruby doesn't care about whitespace, we'd advise you to write an HoH with
lots of indentation.

Take a moment to reflect, can you "see" the tree's nodes. Each entity ("Eddie
Fisher", "Debbie Reynolds" and "Carrie Fisher") are the same _thing_ (a person)
with another "generation" of `Hash` data accessible via uniform _keys_. This
means that we can "tunnel" through the infinite regress of HoHs to get data.

We've kept the regress very shallow here (2 generations), but you can imagine a
longer family tree could be quite deep indeed!

## Read Scalar Data From a Nested Array

One of the defining features of HoHs is that we use stacked keys to get data
out of the complex tree.  To read an element from a HoH simply "stack" keys:

```ruby
child = {
  :name=>"Carrie Fisher",
  :mother=>{
    :name=>"Debbie Reynolds",
    :mother=>{
      :name=> "Maxene Reynolds"
    },
    :father=>{}
  },
  :father=>{
    :name=>"Eddie Fisher",
    :mother=>{},
    :father=>{}
  }
}

child[:mother][:name] #=> "Debbie Reynolds"
child[:mother][:mother][:name] #=> "Maxene Reynolds"
```

Through this "stacking" across "generations" we can see that Carrie Fisher's
grandmother's name was "Maxene."

> **PRO TIP**: When building HoHs, it's wise to ensure you have all the data
> uniform. We should ensure that we have the mother / father data for "Eddie
> Fisher". To show "end of our knowledge" we've used an empty `Hash`.

## Modify Scalar Data In an Hash of Hashes

The same technique of using coordinates applies both to reading and
modification. If you can "target" an element you can read it or update it.

```ruby
child = {
  :name=>"Carrie Fisher",
  :mother=>{
    :name=>"Debbie Reynolds",
    :mother=>{
      :name=> "Maxene Reynolds"
    },
    :father=>{}
  },
  :father=>{
    :name=>"Eddie Fisher",
    :mother=>{},
    :father=>{}
  }
}

child[:mother][:father] = "Raymond Reynolds"
child # => => {:name=>"Carrie Fisher", :mother=>{:name=>"Debbie Reynolds", :mother=>{:name=>"Maxene Reynolds"}, :father=>"Raymond Reynolds"}, :father=>{:name=>"Eddie Fisher", :mother=>{}, :father=>{}}}
child[:mother][:father] #=> "Raymond Reynolds"
```

You can also replace inner `Hash`es with new `Hash`es:

```ruby
child = {
  :name=>"Carrie Fisher",
  :mother=>{
    :name=>"Debbie Reynolds",
    :mother=>{
      :name=> "Maxene Reynolds"
    },
    :father=>{
      :name=> "Raymond Reynolds"
    }
  },
  :father=>{
    :name=>"Eddie Fisher",
    :mother=>{},
    :father=>{}
  }
}

child[:father][:mother] = {name: "Gitte Winokur", mother: {}, father: {}}
child #=> => {:name=>"Carrie Fisher", :mother=>{:name=>"Debbie Reynolds", :mother=>{:name=>"Maxene Reynolds"}, :father=>{:name=>"Raymond Reynolds"}}, :father=>{:name=>"Eddie Fisher", :mother=>{:name=>"Gitte Winokur", :mother=>{}, :father=>{}}, :father=>{}}}
```

## Conclusion

Congratulations, you've learned to use your second nested data structure: the
`Array` of `Hash`es. You've seen that you can build them by building `Array`s
filled with variables that point to `Hash`es, or that you can use literal
notation to build them out.

You've seen that you can use coordinates to look up elements in the AoH as well
as update those elements. In the lab associated with this material, you'll have
a chance to make sure you've understood the basics.

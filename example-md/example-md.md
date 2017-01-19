# Sections & Paragraphs

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur pharetra enim ut eros pharetra, in varius nunc commodo. Curabitur sed tellus efficitur, pretium sapien et, auctor urna. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Mauris id maximus sapien. Praesent malesuada sem sed felis volutpat porttitor. Aenean commodo cursus metus, in laoreet lacus tincidunt vel. Praesent a quam eu mauris lacinia viverra. Proin aliquet, risus nec interdum laoreet, leo dolor dapibus neque, ac fermentum libero urna posuere mauris. Ut quis ullamcorper ante, ut vulputate erat. Nulla condimentum sagittis dui, vitae facilisis mi blandit nec. Cras id suscipit enim.


## Subsection

Cras enim nisi, molestie quis neque vel, aliquet laoreet metus. Maecenas ut venenatis leo. Suspendisse malesuada ligula maximus, varius lorem sed, ullamcorper tellus. Vestibulum turpis nisi, pellentesque in dictum at, finibus sit amet ligula. Mauris fermentum pharetra dolor lacinia vestibulum. Nunc eget feugiat mauris, ac posuere erat. Pellentesque a rhoncus justo, at consectetur elit. Sed condimentum, ligula sit amet hendrerit viverra, dolor mi dictum turpis, sit amet accumsan arcu urna et sapien. Donec rutrum hendrerit mauris, eu faucibus purus rhoncus vitae. Aliquam vitae pellentesque dolor, non tempus nulla. Etiam vitae justo tortor. Aenean sodales eu lorem eu luctus.


### Subsubsection

In euismod neque ut purus pellentesque tincidunt. Nullam bibendum sagittis ultrices. Nunc nunc arcu, maximus nec lorem et, auctor lacinia ante. Donec dapibus scelerisque ante, at pulvinar odio euismod non. Nam in consequat diam, quis auctor diam. Praesent at luctus felis. Vivamus gravida finibus iaculis. Nunc turpis erat, ullamcorper eu fringilla ac, faucibus eu eros.


## Formating

You can write text with different *emphasis*. For really important stuff, you can even have **strong emphasis**.

Subscript as in H~2~O is possible. So is superscript: 2^10^.


# Math

You can write math as part of a sentence. For example, did you know that $1+2=3$?

You can also have math in blocks:

$$e = mc^2$$



# References

Blah blah [see @doe99, pp. 33-35; also @smith04, chap. 1].

Blah blah [@doe99, pp. 33-35 and 38-39].

Blah blah [@smith04; @doe99].

Smith says blah [-@smith04].

@smith04 says blah.

@smith04 [p. 33] says blah.



# Code

### Inline code

Lorem ipsum dolor sit amet, consectetur adipiscing elit. `x <- stats::rnorm(n)` Curabitur pharetra enim ut eros pharetra, in varius nunc commodo. Curabitur sed tellus efficitur, pretium sapien et, auctor urna.


### Code without highlighting

```
for(i in 1:5) print(1:i)
for(n in c(2,5,10,20,50)) {
   x <- stats::rnorm(n)
   cat(n, ": ", sum(x^2), "\n", sep = "")
}
f <- factor(sample(letters[1:5], 10, replace = TRUE))
for(i in unique(f)) print(i)
```

### Code with highlighting

```r
for(i in 1:5) print(1:i)
for(n in c(2,5,10,20,50)) {
   x <- stats::rnorm(n)
   cat(n, ": ", sum(x^2), "\n", sep = "")
}
f <- factor(sample(letters[1:5], 10, replace = TRUE))
for(i in unique(f)) print(i)
```


# Figures

![This is Neyman](example-md/neyman.jpg)


# Footnotes

Cras enim nisi, molestie quis neque vel, aliquet laoreet metus.[^1] Vestibulum turpis nisi, pellentesque in dictum at, finibus sit amet ligula. Mauris fermentum pharetra dolor lacinia vestibulum.^[Nunc eget feugiat mauris, ac posuere erat.] Pellentesque a rhoncus justo, at consectetur elit. Sed condimentum, ligula sit amet hendrerit viverra, dolor mi dictum turpis, sit amet accumsan arcu urna et sapien. Donec rutrum hendrerit mauris, eu faucibus purus rhoncus vitae. Aliquam vitae pellentesque dolor, non tempus nulla. Etiam vitae justo tortor. Aenean sodales eu lorem eu luctus.

[^1]: Maecenas ut venenatis leo. Suspendisse malesuada ligula maximus, varius lorem sed, ullamcorper tellus.

# Links

### Simple links

If you want the link and the text to be the same, just write: <http://google.com>.

If you want the link text to be different from the link, write: [Google](http://google.com).

Sometimes you need to re-use the link a lot, and it might then make sense to use links by references.
For example, if you use [Google] to [Google] about [Google]. This even works if you want to change the [link text][Google].

[Google]: http://google.com "Google"


# Block quotations

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur pharetra enim ut eros pharetra, in varius nunc commodo. Curabitur sed tellus efficitur, pretium sapien et, auctor urna. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.

> Mauris id maximus sapien. Praesent malesuada sem sed felis volutpat porttitor. Aenean commodo cursus metus, in laoreet lacus tincidunt vel.

Praesent a quam eu mauris lacinia viverra. Proin aliquet, risus nec interdum laoreet, leo dolor dapibus neque, ac fermentum libero urna posuere mauris. Ut quis ullamcorper ante, ut vulputate erat. Nulla condimentum sagittis dui, vitae facilisis mi blandit nec. Cras id suscipit enim.

# Lists

### Bullet lists

* Bullet 1
* Bullet 2
* Bullet 3
* Bullet 4


### Ordered lists

1. Ordered 1
2. Ordered 2
3. Ordered 3
4. Ordered 4


# Tables

| Right | Left | Default | Center |
|------:|:-----|---------|:------:|
|   12  |  12  |    12   |    12  |
|  123  |  123 |   123   |   123  |
|    1  |    1 |     1   |     1  |

  : An example of a table.


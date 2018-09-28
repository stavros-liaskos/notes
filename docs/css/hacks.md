# Tricks

## Target only one browser version ..
```css
#element { 
  color:pink \0/IE9; // (only for IE9!) 
} 
```
[Source](https://stackoverflow.com/questions/12296628/need-hack-for-ie9-only)

## Select all but the first
```css
p + p {
  background: cyan;
}
```
[Source](https://codepen.io/stavros-liaskos/pen/oPJjaq)

## CSS Rules Priority
```scss
.footer { 
  .footer-item { 
    background: red; 
  } 
}

.footer-item { 
  background: green; 
}
```
In the end the nested property prevails: `background: red;`  
[Source](https://codepen.io/stavros-liaskos/pen/aaOowE)


## View variable value
```scss
span {
  $post: 'Vipers';
  
  &::after {
    content: $post; 
  }
}
```
[Source](https://codepen.io/stavros-liaskos/pen/QVbLmE)

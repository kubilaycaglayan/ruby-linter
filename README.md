[![hire-badge](https://img.shields.io/badge/Consult%20/%20Hire%20Kubilay-Click%20to%20Contact-brightgreen)](mailto:kblycaglayan@gmail.com) [![Twitter Follow](https://img.shields.io/twitter/follow/kbcaglayan?label=Follow%20Kubilay%20on%20Twitter&style=social)](https://twitter.com/kbcaglayan)

# Ruby Linter
In this project I made a linter for Ruby. It can detects basic syntax errors on targeted files according to ruby syntax rules.

## It can detect:

This linter is susceptible to following keywords: **def**, **class**, **module**, **if**, **end**.
Using this linter out of the context is not approved.

### Indentation Cop 
Detects indentation with the rules of two spaces indentation.

#### \# good
```
def my_method(arg1, arg2)
  variables = 12
end
```

#### \# bad
```
def my_method(arg1, arg2)
  variables = 12
  end
```
### Soft Paranthese Missing Cop 
Calculates the total number of soft parantheses and returns the line number if closing and opening parantheses numbers doesn't match.

#### \# good
```
def my_method(arg1, arg2)
  variables = 12
end
```

#### \# bad
```
def my_method(arg1, arg2
  variables = 12
end
```

### Square Bracket Missing Cop 
Does the same for square brackets.
#### \# good
```
def my_method(arg1, arg2)
  variables = [12]
end
```

#### \# bad
```
def my_method(arg1, arg2)
  variables = [12
end
```

### Curly Bracket Missing Cop
Does the same for curly brackets.
#### \# good
```
def my_method(arg1, arg2)
  variables = { symbol: "sample" }
end
```

#### \# bad
```
def my_method(arg1, arg2)
  variables = { symbol: "sample" 
end
```
### Extra Space Cop 
It scans the lines and returns a note if it finds a bigger space than 1 character.
#### \# good
```
def my_method(arg1, arg2)
  variables = { symbol: "sample" }
end
```

#### \# bad
```
def my_method(arg1,     arg2)
  variables = { symbol: "sample" }
end
```

### New Line Cop
If there is a keyword immediately before the 'end' keyword it returns an error message.

#### \# good
```
def my_method(arg1, arg2)
  variables = { symbol: "sample" }
end

def my_method2(arg1, arg2)
  variables = { symbol: "sample" }
end
```

#### \# bad
```
def my_method(arg1, arg2)
  variables = { symbol: "sample" }
end
def my_method2(arg1, arg2)
  variables = { symbol: "sample" }
end
```
### Keyword 'end' Missing Cop
If the keywords numbers doesn't match with the **end** numbers it returns an error message with the line number of the latest end.
#### \# good
```
def my_method(arg1, arg2)
  variables = { symbol: "sample" }
end
```

#### \# bad
```
def my_method(arg1, arg2)
  variables = { symbol: "sample" }

```

### Example Output
![Screenshot_2020-04-12_21-04-34](https://user-images.githubusercontent.com/60448833/79076414-9a476c00-7d02-11ea-9b49-ecec36623db7.png)


## Built With

- Ruby
- RSpec
- Rubocop

### Prerequisites

- Ruby installed on local machine

### Usage

- Fork/Clone this project to your local machine
- Please type ``bundle install`` first. To install dependencies.
- Open main.rb in your local enviroment
- Or you can basically type ``main.rb file/path/you/want/to/check.rb `` on command line.

## Author

👤 **Kubilay Caglayan**

- Github: [@kblycaglayan](https://github.com/kblycaglayan)
- Twitter: [@kbcaglayan](https://twitter.com/kbcaglayan)
- LinkedIn: [Kubilay](https://www.linkedin.com/in/kubilaycaglayan/)
- Email: [kblycaglayan@gmail.com](mailto:kblycaglayan@gmail.com)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](https://github.com/kblycaglayan/Enumerable-Methods/issues)

Start by:

- Forking the project
- Cloning the project to your local machine
- `cd` into the project directory
- Run `git checkout -b your-branch-name`
- Make your contributions
- Push your branch up to your forked repository
- Open a Pull Request with a detailed description to the development(or master if not available) branch of the original project for a review

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- The Odin project for the project plan
- https://docs.rubocop.org/en/stable/

## 📝 License

This project is [MIT](LICENSE.md) licensed

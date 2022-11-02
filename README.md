This library is used to show contents as a popover view on iPhone just like iPad and this library is supported for SwiftUI only.

## Installation
To install use swift package manager
URL:
`https://github.com/ahsanateeq/popoverswiftUI.git`

## Usage

- First Import Libarary
`import PopoverSwiftUI`

- Then use as modifier
```swift
    .popoverView(isPresented: $showsAlwaysPopover) {
        Content() // Content for popover view
    }
```


## Extra

**Code Sample:**

```swift
    Button("Custom Always Popover") {
        showsAlwaysPopover = true
    }
    .popoverView(isPresented: $showsAlwaysPopover,
                    arrows: UIPopoverArrowDirection.up, // default arrow direction: .any
                    background: Color.cyan) {           // default background color: nil
        PopoverContent()
    }
```

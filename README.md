Food File
=========

Provides a standardized format for laying out recipes using XML
and then compiling shopping lists using XSLT.
For example:

```xml
<Recipe Title="Meat stew and dumplings" Meals="2" >
    <Index>
        Stew<Sub>Meat and dumplings</Sub>
    </Index>
    <Index>Dumplings</Index>
    <Stage>
        <Staple Name="potatoes" />
    </Stage>
    <Stage>
        In a <Utensil Name="wok" /> fry
        (in <Check Quantity="4" Name="oil" Unit="tbsp" />)
        <Vegetable Process="chopped" Quantity="320" Name="onions" Unit="g" />,
        <Meat Process="sliced" Quantity="400" Name="meat" Unit="g" />,
        <Vegetable Process="chopped" Quantity="400" Name="carrots" Unit="g" />
        and
        <Vegetable Process="chopped" Quantity="400" Name="celery" Unit="g" />
        until the meat is done.
    </Stage>
```

To create the LaTeX document

    dotnet run --project ConsoleApp

Then compile the LaTeX document

	pdflatex FoodFile.tex
	MakeIndex FoodFile.tex
	pdflatex FoodFile.tex
	

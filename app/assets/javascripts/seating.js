function Table(tableNumber, guests) {
    this.chairs = [];
    this.tableNumber = tableNumber;
    this.initTable = function () {
        for (var i = 0; i < guests.length; i++) {
            var currentGuest = guests[i];
            var currentChair = new Chair(i, currentGuest);
            this.chairs.push(currentChair);
        }
        console.log(this.chairs);
    };
}

function Chair(number, guest) {
    this.number = number;
    this.guest = guest;
}

var Seating = function(){
    var settings = {
        drawPanel:{
            name: $(".seating-panel"),
            rectangleTable: $("#seating-panel-rectangle-table")
        },
        drawArea: $(".seating-area"),
        tables: {
            tableStartNumber: 1,
            tableStartName: "seating-table-",
            tableList: [],
            tableHTML: "<div class='seating-panel-table'></div>"
        }
    };

    var init = function() {
        enablePanelRectangleTable();
    };

    var enablePanelRectangleTable = function() {
        var table = settings.drawPanel.rectangleTable;
        table.draggable({
            drag: function() {
                table.draggable('destroy');
                var table1guests = ["Синкевич Мария Сергеевна", "Синкевич Алексей Викторович", "Мисан Андрей Викторович"],
                    table2guests = ["Синкевич Ольга Борисовна", "Синкевич Виктор Семенович", "Рудько Елена Владимировна", "Рудько Сергей Петрович"];

                createNewTable(settings.tables.tableStartNumber, table1guests);
                enablePanelRectangleTable();
            }
        });

    };

    var createNewTable = function(index, tableGuests) {
        var table = new Table(index, tableGuests),
            tableID = settings.tables.tableStartName + index;
        table.initTable();
        settings.tables.tableList.push(table);
        settings.tables.tableStartNumber++;
        var newHTMLTable = $(settings.tables.tableHTML).attr("id", tableID).draggable();
        settings.drawArea.append(newHTMLTable);
    };

    return {
        "initSeating" : init
    }
}();

Seating.initSeating();


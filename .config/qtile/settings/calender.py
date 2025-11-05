import calendar
from datetime import datetime

from qtile_extras.popup import PopupRelativeLayout, PopupText


class CalendarPopup:
    def __init__(self):
        self.started = False
        self.current_date = datetime.now()
        self.displayed_month = self.current_date.month
        self.displayed_year = self.current_date.year

    def _get_time(self):
        now = datetime.now()
        return now.strftime("%H:%M")

    def _get_month_name(self):
        now = datetime.now()
        return now.strftime("%B")

    def _increment_month_year(self, year, month):
        month += 1
        if month > 12:
            month = 1
            year += 1
        return datetime(year=year, month=month, day=1)

    def _decrement_month_year(self, year, month):
        month -= 1
        if month < 1:
            month = 12
            year -= 1
        return datetime(year=year, month=month, day=1)

    def _get_month_range(self, year, month):
        prev_month = month - 1 if month > 1 else 12
        prev_year = year if month > 1 else year - 1

        _, last_day_prev_month = calendar.monthrange(prev_year, prev_month)

        cal = calendar.Calendar()
        month_days = cal.monthdayscalendar(year, month)

        missing_days_at_start = month_days[0].count(0)

        for i in range(missing_days_at_start):
            month_days[0][i] = last_day_prev_month - missing_days_at_start + i + 1

        day_counter = 1
        for i, day in enumerate(month_days[-1]):
            if day == 0:
                month_days[-1][i] = day_counter
                day_counter += 1

        return month_days

    def _append_weekdays_row(self, controls, y):
        element_width = 1.0 / 7
        weekdays = ["Mon", "Tue", "Wed", "Thur", "Fri", "Sat", "Sun"]

        for i, day in enumerate(weekdays):
            x_coordinates = i * element_width
            new_widget = PopupText(
                text=day,
                pos_x=x_coordinates,
                pos_y=y,
                width=element_width,
                height=0.1,
                h_align="center",
            )
            controls.append(new_widget)

    def _append_month_days(self, controls, start_y):
        element_width = 1.0 / 7

        rows = self._get_month_range(
            year=self.current_date.year, month=self.current_date.month
        )
        for rc, row in enumerate(rows):
            for i, day in enumerate(row):
                x_coordinates = i * element_width

                new_widget = PopupText(
                    name=f"row_{rc}_col_{i}",
                    text=str(day),
                    pos_x=x_coordinates,
                    pos_y=start_y,
                    width=element_width,
                    height=0.1,
                    h_align="center",
                    highlight_method="border",
                    highlight="#ffffff",
                )

                controls.append(new_widget)
            start_y = start_y + 0.1

    def _update_date_time(self):
        if not hasattr(self, "layout") or self.layout is None:
            return

        month_name = self._get_month_name()
        year = self.current_date.year
        time = self._get_time()

        self.layout.update_controls(
            time_center=str(time), month_year_left=f"{month_name} {year}"
        )

    def _create_layout(self, qtile):
        month_name = self.current_date.strftime("%B")

        self.displayed_month = self.current_date.month
        self.displayed_year = self.current_date.year

        controls = [
            PopupText(
                name="time_center",
                text=self._get_time(),
                pos_x=0.0,
                pos_y=0.0,
                width=1,
                height=0.25,
                fontsize=76,
                h_align="center",
                # background="ffffff"
            ),
            PopupText(
                name="month_year_left",
                font="JetBrainsMono Nerd Font Mono Bold",
                text=f"{month_name} {self.current_date.year}",
                pos_x=0.1,
                pos_y=0.3,
                width=0.5,
                height=0.1,
                fontsize=20,
                h_align="left",
            ),
            PopupText(
                font="JetBrainsMono Nerd Font Mono Bold",
                text="",
                pos_x=0.8,
                pos_y=0.3,
                width=0.1,
                height=0.1,
                fontsize=30,
                h_align="center",
                highlight="#ffffff",
                highlight_method="border",
                mouse_callbacks={"Button1": lambda: self.on_next_month()},
            ),
            PopupText(
                font="JetBrainsMono Nerd Font Mono Bold",
                text="",
                pos_x=0.7,
                pos_y=0.3,
                width=0.1,
                height=0.1,
                fontsize=30,
                h_align="center",
                highlight="#ffffff",
                highlight_method="border",
                mouse_callbacks={"Button1": lambda: self.on_previous_month()},
            ),
        ]

        # append weekdays
        self._append_weekdays_row(controls, 0.4)

        # append days
        self._append_month_days(controls, 0.5)

        self.layout = PopupRelativeLayout(
            qtile,
            width=500,
            height=500,
            border="000000",
            border_width=2,
            controls=controls,
            background="000000",
            initial_focus=None,
            close_on_click=False,
        )

    def on_next_month(self):
        incremented_date = self._increment_month_year(
            self.displayed_year, self.displayed_month
        )
        new_month_range = self._get_month_range(
            incremented_date.year, incremented_date.month
        )

        new_values_dict = {}

        for rc, row in enumerate(new_month_range):
            for i, day in enumerate(row):
                new_values_dict[f"row_{rc}_col_{i}"] = str(day)

        new_values_dict["month_year_left"] = (
            f'{incremented_date.strftime("%B")} {
            incremented_date.year}'
        )

        self.layout.update_controls(**new_values_dict)
        self.displayed_month = incremented_date.month
        self.displayed_year = incremented_date.year

    def on_previous_month(self):
        decremented_date = self._decrement_month_year(
            self.displayed_year, self.displayed_month
        )
        new_month_range = self._get_month_range(
            decremented_date.year, decremented_date.month
        )

        new_values_dict = {}

        for rc, row in enumerate(new_month_range):
            for i, day in enumerate(row):
                new_values_dict[f"row_{rc}_col_{i}"] = str(day)

        new_values_dict["month_year_left"] = (
            f'{decremented_date.strftime("%B")} {
            decremented_date.year}'
        )

        self.layout.update_controls(**new_values_dict)
        self.displayed_month = decremented_date.month
        self.displayed_year = decremented_date.year

    def toggle(self, qtile):
        if not self.started:
            self._create_layout(qtile)
            self.layout.show(relative_to=2, relative_to_bar=True)
            self._update_date_time()
            self.started = True
        else:
            self.layout.hide()
            self.started = False


calendar_popup = CalendarPopup()


def toggle_calendar_popup(qtile):
    calendar_popup.toggle(qtile=qtile)

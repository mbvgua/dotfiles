import typer
from rich import print
import subprocess
import os
from dotenv import load_dotenv

load_dotenv()

app = typer.Typer()
main_session = os.environ.get("MAIN_SESSION")
lab_session = os.environ.get("LAB_SESSION")
careers_session = os.environ.get("CAREERS_SESSION")
user_email = os.environ.get("USER_EMAIL")

session_catalogue = {
    "[1] Morning rollcall": "Basic standup and checkin session (9:00am - 9:20am)",
    "[2] Morning session": "Main lesson for first half, with assigned teachOps (9:30am - 11:00am)",
    "[3] Morning lab": "Hands-on lab based on morning session (11:00am - 12:00pm)",
    "[4] Evening session": "Main lessons for the second half, with assigned teachOps (2:00pm - 4:30pm)",
    "[5] Evening lab": "Hands-on lab based on evening session (4:30pm - 5:00pm)",
    "[6] Careers session": "Receive career guidance from counsellor!",
}


@app.command()
def choose_session():
    print("Below is a list of available sessions: ")
    print(" ")
    for key, value in session_catalogue.items():
        print(f"[cyan] {key} [/cyan]: {value}")

    print(" ")
    user_choice = int(typer.prompt("Please choose one(1-6)"))
    if (user_choice == 1) or (user_choice == 2) or (user_choice == 4):
        print("You choose either the [cyan]Morning[/cyan] rollcall/session or [cyan]Evening[/cyan] session.")
        subprocess.run(
            [
                "teams-for-linux",
                "--closeAppOnCross",
                "--followSystemTheme",
                "--url ",
                main_session,
            ],
            capture_output=True,
        )
    elif (user_choice == 3) or (user_choice == 5):
        print("You choose either the [cyan]Morning[/cyan] or [cyan]Evening[/cyan] lab session.")
        subprocess.run(
            [
                "teams-for-linux",
                "--closeAppOnCross",
                "--followSystemTheme",
                "--url ",
                lab_session,
            ],
            capture_output=True,
        )
    elif user_choice == 6:
        print("You choose the [cyan]careers[/cyan] session.")
        subprocess.run(
            [
                "teams-for-linux",
                "--closeAppOnCross",
                "--followSystemTheme",
                "--url ",
                careers_session,
            ],
            capture_output=True,
        )
    else:
        print("You selected an invalid choice, please try again.")


if __name__ == "__main__":
    app()

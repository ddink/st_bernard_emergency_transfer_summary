# St. Bernard Emergency Transfer Summary

This project is a simple prototype for a minimalistic electronic medical record (EMR) app for remote nursing and emergency facilities. I was asked to put this prototype together for a work opportunity in 2019, however, my personal life intervened and I was not able to follow up on it. I never actually got the chance to attempt this code prompt. 

Instead I decided to build this prototype for some practice and for a recent addition to my portfolio.


## Requirements

Per the prompt:

"This prototype should render an emergency summary template, parsing and interpolating different placeholders from persisted data. The prototype must be compatible with the Saint Bernard app, a **Ruby on Rails** web application using **SQLite** for data storage and **Bootstrap 3** for the UI."

"It is important you deliver legible, clean, and extensible code that other developers can integrate to satisfy more requirements. You must also provide enough test coverage to guaranty a reliable demo to the client, helping other developers to refactor and improve your code."

**User Story**

"As an emergency staff, and after selecting a patient from a list, I want to view the corresponding emergency summary with the option to print."

## Execution

I estimated this project would take at least 40 hours, so I set aside a week early on in February 2021 to work on it. 

I started with the project's configuration by adding gems needed for testing like `rspec`, `shoulda`, and `factory_bot_rails`. I then added the requested models along with their corresponding factories, specs, associations, and validations. The  models' common functionality got refactored into two modules, `DateTimeFormat` and `DescriptionFormat`. 

The patient model took center stage for this project as it was the only resource that required routes. 

The crux of this prototype is the `show_transfer_summary?` helper method, which determines what kind of user (emergency staff only) gets to view the emergency transfer summary. 

The patient model's `emergency_transfer_summary` method is also critical to correctly displaying all of the various data stored by the associated models in one place.

Next up, I worked on the prototype's views. Although the prototype contains routes for all of the patient controller's actions, the only two views relevant to the prototype are those for the patients index route (`/patients`) and the patients show route (`/patients/:id`). 

Lastly I added database seeding so that anyone who clones this repo doesn't have to go through the tedious steps of creating their own data. So make sure to run `rails db:seed`.

## How it works

Run `rails s`, go to `http://localhost:3000/patients` in your browser, and click on the 'Show' link for any of the patients on the list. 

Because the `current_user` helper method is always looking for an emergency staff user and the seed data provides an emergency staff user by default, you will able to see the Emergency Transfer Summary for each patient.
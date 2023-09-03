Shoes.app width: 500, height: 600 do
  @filepath = "/lea"
  @sections = [
    {
      title: "Lea wants to go to RailsWorld",
      context: "Lea is a Ruby on Rails developer in Scotland. She really wants to go to RailsWorld.
        Unfortunatley, Lea assumed that the idea that conferences sold out of tickets was actually a myth. Lea missed the 45 minutes of tickets sales to RailsWorld due to this niavety. What should Lea do?",
      buttons: {
        pass: "Start listening to The Ruby on Rails podcast",
        fail: "Lea doesn't feel like listening to podcasts today",
      },
      image_path: "#{@filepath}/sold_out.jpeg",
    },
    {
      title: "Maybe Lea can go to rails world!",
      context: "Listening to this podcast, Lea discovers she may yet have a chance! How exciting!
        Lea only needs to write a compelling app in Scarpe to win a ticket - how hard could it be?",
      buttons: {
        pass: "Let's have a look at the contest!",
        fail: "Sounds like too much work",
      },
      image_path: "#{@filepath}/podcast.jpeg",
    },
    {
      title: "Lea only needs to upgrade Ruby",
      context: "Alright, let's not panic, but it looks like Scarpe requires ruby => 3.2, and Lea's machine is on
              3.1.4. That's fine, lets just 'ruby-install 3.2.2' (the latest version) and we can use Chruby to manage it.
              Can you input the command to install the correct version on Lea's machine?",
      input: {
        correct: "ruby-install 3.2.2",
      },
      image_path: "#{@filepath}/update.jpeg",
    },
    {
      title: "Bloops is making Lea feel stupid",
      context: "Great, that worked! Now we have the correct version of ruby installed, let's follow the next step.
        It looks like we need to brew install some dependencies and then clone the repository. Lets see...",
      appends: [
        "AHHHH It's a horrible error message!! Time to debug for a couple hours. ",
        "So restarting everything didn't work. ",
        "What on EARTH is bloops?! ",
        "Bloops is making you feel stupid? ME TOO! ",
        "Should I change careers? ",
        "NO. Let's ask someone for help, probably someone in the platform team..",
        "Daniel!! Help! (Please) ",
        "Oh, I need to override homebrew directories because I'm on an M1? ",
        "Oh, you figured that out in 5 minutes even though I was debugging it for 2 hours and got nowhere? ",
        "Thanks Daniel!",
      ],
      buttons: {
        pass: "brew install portaudio && bundle config build.bloops --with-portaudio-dir=$(brew --prefix portaudio)",
        fail: "Why even bother?",
      },
      image_path: "#{@filepath}/dependencies.jpeg",
    },
    {
      title: "Lea only needs to read the Shoes manual",
      context: "GREAT! Finally, it only took a few hours *cough* days *cough* to get Lea's environment up to scratch!
        Lea can run the examples now and they work! How exciting. Now, lets take a look at that Shoes manual. I wonder what Lea will learn from here",
      alert: {
        button_text: "Click me!",
        text: "It looks like I can create alerts!",
      },
      buttons: {
        pass: "Keep reading",
        fail: "Surely that's enough",
      },
      image_path: "#{@filepath}/it_works.jpeg",
    },
    {
      title: "Lea only needs to read the Shoes manual",
      context: "What are stacks and flows? They seem vital - I hope I can figure out how to use them",
      stacked: true,
      buttons: {
        pass: "Keep reading",
        fail: "Surely that's enough",
      },
      image_path: "#{@filepath}/stacks.jpeg",
    },
    {
      title: "Lea only needs to read the Shoes manual",
      context: "Maybe Lea's app can have nice, colourful, backgrounds?",
      stacked: true,
      background: true,
      buttons: {
        pass: "Keep reading",
        fail: "Surely that's enough",
      },
      image_path: "#{@filepath}/background.jpeg",
    },
    {
      title: "Lea only needs to read the Shoes manual",
      context: "It looks like some of these features like 'urls' and 'ovals' haven't yet been implemented. (Although her attempt at a star looks like an oval...)
        Lea is feeling pretty invested in shoes now... maybe she could get involved with shoes after this project?",
      stacked: true,
      background: true,
      shapes: true,
      buttons: {
        pass: "Keep reading",
        fail: "Surely that's enough",
      },
      image_path: "#{@filepath}/star.jpeg",
    },
    {
      title: "Lea only needs to create a Scarpe app",
      context: "That manual was super helpful, I guess all that's left is to think of is an idea for an app.
        The important question is - does Lea get to RailsWorld? Submit her app to find out!",
      stacked: true,
      background: true,
      alert: {
        button_text: "Submit Scarpe App",
        text: "Now this one is actually up to you to decide!",
      },
      final_section: true,
      image_path: "#{@filepath}/final.jpeg",
    },
  ]

  @counter = 0
  @box = flow width: "100%", margin: "20px" do
    banner "Lea Learns Shoes"
    subtitle "Can you help Lea learn shoes to get to Rails World?"
    button("Let's go!") do
      display_section
    end
    image "#{@filepath}/shoes.jpeg"
  end

  def display_section
    @box.clear do
      current_section = @sections[@counter]
      if current_section.key?(:stacked)
        stack(width: "50%") do
          background blue(0.5) if current_section.key?(:background)
          subtitle current_section[:title]
        end
      else
        subtitle current_section[:title]
      end
      if current_section.key?(:stacked)
        stack(width: "50%") do
          background pink(0.5) if current_section.key?(:background)
          tagline current_section[:context]
        end
      else
        tagline current_section[:context]
      end

      if current_section.key?(:appends)
        button("Continue") do
          current_section[:appends].each do |extra_text|
            @box.append { para extra_text }
            sleep 0.1
          end
          @box.append { buttons current_section[:buttons] }
        end
      else
        if current_section.key?(:alert)
          button(current_section[:alert][:button_text]) do
            alert current_section[:alert][:text]
          end
        end
        if current_section.key?(:stacked)
          flow(width: "100%") do
            background yellow(0.5) if current_section.key?(:background)
            buttons current_section[:buttons] if current_section.key?(:buttons)
          end
        elsif current_section.key?(:buttons)
          buttons current_section[:buttons]
        end

        if current_section.key?(:shapes)
          star(100, 50, 5, 50)
          para "<- This isn't a star but I'm running out of time"
        end

        if current_section.key?(:input)
          @submission = edit_line
          button("submit") do
            if @submission.text == current_section[:input][:correct]
              @counter += 1
              display_section
            else
              no_rails_world
            end
          end
        end
      end
      image current_section[:image_path]
    end
  end

  def no_rails_world
    @box.clear do
      banner "Lea is NOT going to rails world :("
      image "#{@filepath}/fail.jpeg"
    end
  end

  def buttons(button_hash)
    button(button_hash[:pass]) do
      @counter += 1
      display_section
    end
    button(button_hash[:fail]) do
      no_rails_world
    end
  end
end


defmodule WaniKani.Schema do
  use Absinthe.Schema
  import Absinthe.Resolution.Helpers

  import_types(Absinthe.Type.Custom)

  object :assignment do
    field(:id, :id)
    field(:url, :string)

    field(:srs_stage, :integer)
    field(:hidden, :boolean)

    field(:subject_id, :id)
    field(:subject, :subject, resolve: dataloader(:subject))
    field(:subject_type, :string)

    # todo - datetime
    field(:started_at, :string)
    # todo - datetime
    field(:available_at, :string)
    # todo - datetime
    field(:burned_at, :string)
    # todo - datetime
    field(:created_at, :string)
    # todo - datetime
    field(:passed_at, :string)
    # todo - datetime
    field(:resurrected_at, :string)
    # todo - datetime
    field(:unlocked_at, :string)
  end

  object :level_progression do
    field(:id, :id)
    field(:url, :string)

    field(:level, :integer)
    # todo - datetime
    field(:abandoned_at, :string)
    # todo - datetime
    field(:completed_at, :string)
    # todo - datetime
    field(:created_at, :string)
    # todo - datetime
    field(:passed_at, :string)
    # todo - datetime
    field(:started_at, :string)
    # todo - datetime
    field(:unlocked_at_at, :string)
  end

  object :reset do
    field(:id, :id)
    field(:url, :string)

    # todo - datetime
    field(:created_at, :string)
    # todo - datetime
    field(:confirmed_at, :string)
    field(:original_level, :integer)
    field(:target_level, :integer)
  end

  object :review do
    field(:id, :id)
    field(:url, :string)

    # todo - datetime
    field(:created_at, :string)
    field(:ending_srs_stage, :integer)
    field(:incorrect_meaning_answers, :integer)
    field(:incorrect_reading_answers, :integer)
    field(:starting_srs_stage, :integer)

    field(:assignment_id, :id)
    field(:assignment, :assignment, resolve: dataloader(:assignment))

    field(:subject, :subject, resolve: dataloader(:subject))
    field(:subject_id, :id)

    field(:spaced_repetition_system_id, :id)
  end

  object :review_statistic do
    field(:id, :id)
    field(:url, :string)

    # todo - datetime
    field(:created_at, :string)
    field(:hidden, :boolean)
    field(:meaning_correct, :integer)
    field(:meaning_current_streak, :integer)
    field(:meaning_incorrect, :integer)
    field(:meaning_max_streak, :integer)
    field(:percentage_correct, :integer)
    field(:reading_correct, :integer)
    field(:reading_current_streak, :integer)
    field(:reading_incorrect, :integer)
    field(:reading_max_streak, :integer)
    field(:subject_id, :integer)
    field(:subject_type, :string)
  end

  object :stage do
    field(:interval, :integer)
    field(:interval_unit, :string)
    field(:position, :integer)
  end

  object :spaced_repetition_system do
    field(:id, :id)
    field(:url, :string)

    field(:burning_stage_position, :integer)
    # todo - datetime
    field(:created_at, :string)
    field(:description, :string)
    field(:name, :string)
    field(:passing_stage_position, :integer)
    field(:stages, list_of(:stage))
    field(:starting_stage_position, :integer)
    field(:unlocking_stage_position, :integer)
  end

  object :auxiliary_meaning do
    field(:meaning, :string)
    field(:type, :string)
  end

  object :meaning do
    field(:meaning, :string)
    field(:primary, :boolean)
    field(:accepted_answer, :boolean)
  end

  object :metadata do
    # svg
    field(:inline_styles, :boolean)

    # png
    field(:color, :string)
    field(:dimensions, :string)
    field(:style_name, :string)

    # audio
    field(:gender, :string)
    field(:source_id, :id)
    field(:pronunciation, :string)
    field(:voice_actor_id, :id)
    field(:voice_actor_name, :string)
    field(:voice_description, :string)
  end

  object :character_image do
    field(:url, :string)
    field(:content_type, :string)
    field(:metadata, :metadata)
  end

  object(:readings) do
    field(:reading, :string)
    field(:primary, :boolean)
    field(:accepted_answer, :boolean)
    field(:type, :string)
  end

  object :context_sentence do
    field(:en, :string)
    field(:ja, :string)
  end

  object :pronunciation_audio do
    field(:url, :string)
    field(:content_type, :string)
    field(:metadata, :metadata)
  end

  object :subject do
    field(:auxiliary_meanings, list_of(:auxiliary_meaning))
    field(:characters, :string)
    # todo - datetime
    field(:created_at, :string)
    field(:document_url, :string)
    # todo - datetime
    field(:hidden_at, :string)
    field(:lesson_position, :integer)
    field(:level, :integer)
    field(:meaning_mneomic, :string)
    field(:meanings, list_of(:meaning))
    field(:slug, :string)
    field(:spaced_repetition_system_id, :id)

    # radicals
    field(:character_images, list_of(:character_image))

    # kanji
    field(:amalgamation_object_ids, list_of(:id))
    field(:component_subject_ids, list_of(:id))
    field(:meaning_hint, :string)
    field(:reading_hint, :string)
    field(:reading_mnemonic, :string)
    field(:readings, list_of(:readings))
    field(:visually_similar_subject_ids, list_of(:id))

    # vocabulary
    field(:context_sentences, list_of(:context_sentence))
    field(:parts_of_speech, list_of(:string))
    field(:pronunciation_audios, list_of(:pronunciation_audio))
  end

  object :study_material do
    field(:id, :id)
    field(:url, :string)

    # todo - datetime
    field(:created_at, :string)
    field(:hidden, :boolean)
    field(:meaning_note, :string)
    field(:meaning_synonyms, list_of(:string))
    field(:reading_note, :string)

    field(:subject_id, :id)
    field(:subject, :subject, resolve: dataloader(:subject))
    field(:subject_type, :string)
  end

  object :lesson do
    # todo - datetime
    field(:available_at, :string)
    field(:subject_ids, list_of(:id))
    field(:subjects, list_of(:subject), resolve: dataloader(:subject))
  end

  object :summary_review do
    # todo - datetime
    field(:available_at, :string)
    field(:subject_ids, list_of(:id))
    field(:subjects, list_of(:subject), resolve: dataloader(:subject))
  end

  object :summary do
    field(:url, :string)

    field(:lessons, list_of(:lesson))
    # todo - datetime
    field(:next_reviews_at, :string)
    field(:reviews, list_of(:review))
  end

  object :user_preferences do
    field(:default_voice_actor_id, :id)
    field(:lessons_autoplay_audio, :boolean)
    field(:lessons_batch_size, :integer)
    field(:lessons_presentation_order, :string)
    field(:reviews_autoplay_audio, :boolean)
    field(:reviews_display_srs_indicator, :boolean)
  end

  object :user_subscription do
    field(:active, :boolean)
    field(:max_level_granted, :integer)
    # todo - datetime
    field(:period_ends_at, :string)
    field(:type, :string)
  end

  object :user do
    field(:id, :id)
    field(:url, :string)

    # todo - datetime
    field(:current_vacation_started_at, :string)
    field(:level, :integer)
    field(:preferences, :user_preferences)
    field(:profile_url, :string)
    # todo - datetime
    field(:started_at, :string)
    field(:subscription, :user_subscription)
    field(:username, :string)
  end

  object :voice_actor do
    field(:id, :id)
    field(:url, :string)
    field(:description, :string)
    field(:gender, :string)
    field(:name, :string)
  end

  query do
    # ASSIGNMENTS

    field :assignment, :assignment, resolve: dataloader(:assignment) do
      arg(:id, non_null(:id))
    end

    field(:assignments, list_of(:assignment), resolve: dataloader(:assignment))

    # LEVEL PROGRESSION

    field(:level_progression, :level_progression, resolve: dataloader(:level_progression)) do
      arg(:id, non_null(:id))
    end

    field(:level_progressions, list_of(:level_progression),
      resolve: dataloader(:level_progression)
    )

    # RESETS

    field(:resets, list_of(:reset), resolve: dataloader(:reset))

    field :reset, :reset, resolve: dataloader(:reset) do
      arg(:id, non_null(:id))
    end

    # REVIEWS

    field(:reviews, list_of(:review), resolve: dataloader(:review))

    field :review, :review, resolve: dataloader(:review) do
      arg(:id, non_null(:id))
    end

    # REVIEW STATISTICS

    field(:review_statistics, list_of(:review_statistic), resolve: dataloader(:review_statistic))

    field :review_statistic, :review_statistic, resolve: dataloader(:review_statistic) do
      arg(:id, non_null(:id))
    end

    # SPACED REPETITION

    field(:spaced_repetition_systems, list_of(:spaced_repetition_system),
      resolve: dataloader(:spaced_repetition_system)
    )

    field :spaced_repetition_system, :spaced_repetition_system,
      resolve: dataloader(:spaced_repetition_system) do
      arg(:id, non_null(:id))
    end

    # STUDY MATERIALS

    field(:study_materials, list_of(:study_material), resolve: dataloader(:study_material))

    field :study_material, :study_material, resolve: dataloader(:study_material) do
      arg(:id, non_null(:id))
    end

    # SUMMARY

    field(:summary, :summary, resolve: dataloader(:summary))

    # USER

    field(:user, :user, resolve: dataloader(:user))

    # VOICE ACTORS

    field(:voice_actors, list_of(:voice_actor), resolve: dataloader(:voice_actor))

    field :voice_actor, :voice_actor, resolve: dataloader(:voice_actor) do
      arg(:id, non_null(:id))
    end

    # TODO - Subjects
    # TODO - this is paginated
    # TODO Query parameters

    field(:subjects, list_of(:subject), resolve: dataloader(:subject))

    field :subject, :subject, resolve: dataloader(:subject) do
      arg(:id, non_null(:id))
    end
  end

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(:assignment, WaniKani.Source.Assignment.data())
      |> Dataloader.add_source(:level_progression, WaniKani.Source.LevelProgression.data())
      |> Dataloader.add_source(:reset, WaniKani.Source.Reset.data())
      |> Dataloader.add_source(:review, WaniKani.Source.Review.data())
      |> Dataloader.add_source(:review_statistic, WaniKani.Source.ReviewStatistic.data())
      |> Dataloader.add_source(
        :spaced_repetition_system,
        WaniKani.Source.SpacedRepetitionSystem.data()
      )
      |> Dataloader.add_source(:study_materials, WaniKani.Source.StudyMaterial.data())
      |> Dataloader.add_source(:summary, WaniKani.Source.Summary.data())
      |> Dataloader.add_source(:subject, WaniKani.Source.Subject.data())
      |> Dataloader.add_source(:user, WaniKani.Source.User.data())
      |> Dataloader.add_source(:voice_actor, WaniKani.Source.VoiceActor.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end

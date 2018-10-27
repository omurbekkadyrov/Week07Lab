/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package businesslogic;

import dataaccess.NoteDB;
import domainmodel.Note;
import java.util.Date;
import java.util.List;
/**
 *
 * @author 759388
 */
public class NoteService {
    
    private NoteDB noteDB;

    public NoteService() {
        noteDB = new NoteDB();
    }

    public Note get(int noteId) throws Exception {
        return noteDB.getNote(noteId);
    }

    public List<Note> getAll() throws Exception {
        return noteDB.getAll();
    }

    public int update(int noteId, Date dateCreated, String contents) throws Exception {
        return noteDB.update(new Note(noteId, dateCreated, contents));
    }

    public int delete(int noteId) throws Exception {
        return noteDB.delete(noteDB.getNote(noteId));
    }

    public int insert(Date dateCreated, String contents) throws Exception {
        return noteDB.insert(new Note(dateCreated, contents));
    }
}
